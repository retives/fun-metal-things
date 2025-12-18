class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @cart = current_user.cart
    if @cart.cart_items.empty?
      redirect_to items_path, alert: "Ваш кошик порожній! 🤘"
    end
    @order = Order.new
  end

  def create
    @cart = current_user.cart
    @order = Order.new(order_params)
    @order.user = current_user
    @order.total_price = @cart.total_price

    ActiveRecord::Base.transaction do
      if @order.save
        @cart.cart_items.each do |ci|
          OrderItem.create!(
            order: @order,
            item: ci.item,
            quantity: ci.quantity,
            price_at_purchase: ci.item.price
          )

          item = ci.item
          new_quantity = item.quantity - ci.quantity

          if new_quantity < 0
            raise ActiveRecord::Rollback, "Недостатньо товару #{item.name} на складі"
          end
          item.update!(quantity: new_quantity)
        end

        @cart.cart_items.destroy_all

        redirect_to payment_order_path(@order)
      else
        render :new, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::Rollback => e
    redirect_to cart_path, alert: e.message
  end

  def payment
    @order = current_user.orders.find_by(id: params[:id])
    @session = nil

    @debug_info = {
      order_id: params[:id],
      order_found: @order.present?,
      stripe_key_present: ENV["STRIPE_SECRET_KEY"].present?,
      stripe_key_start: ENV["STRIPE_SECRET_KEY"]&.first(7)
    }

    if @order && @order.order_items.any?
      begin
        @session = Stripe::Checkout::Session.create({
          payment_method_types: [ "card" ],
          line_items: @order.order_items.map { |oi|
            {
              price_data: {
                currency: "uah",
                product_data: {
                  name: oi.item.name,
                  description: "Товар  від FunMetalThings"
                },
                unit_amount: (oi.price_at_purchase.to_f * 100).round
              },
              quantity: oi.quantity
            }
          },
          mode: "payment",
          success_url: confirm_payment_order_url(@order) + "?session_id={CHECKOUT_SESSION_ID}",
          cancel_url: payment_order_url(@order)
        })
      rescue Stripe::StripeError => e
        logger.error "STRIPE API ERROR: #{e.message}"
        @stripe_error = e.message
        @session = nil
      end
    end
  end

  def confirm_payment
    @order = Order.find(params[:id])

    begin
      # 1. ПЕРЕВІРКА СЕСІЇ STRIPE (Security)
      session = Stripe::Checkout::Session.retrieve(params[:session_id])

      if session.payment_status == "paid" && @order.status == "pending"
        ActiveRecord::Base.transaction do
          # 2. ОНОВЛЕННЯ СТАТУСУ (Товар вже списано в 'create')
          @order.update!(status: "paid")

          # 3. ОЧИЩЕННЯ КОШИКА (Навіть якщо він був порожнім)
          current_user.cart.cart_items.destroy_all
        end
        redirect_to order_path(@order), notice: "Оплата пройшла успішно! 🤘"
      else
        # Якщо статус не paid або замовлення вже було оброблене
        redirect_to order_path(@order), alert: "Оплата не підтверджена або замовлення вже оброблене."
      end
    rescue Stripe::InvalidRequestError => e
      logger.error "STRIPE CONFIRM ERROR: #{e.message}"
      redirect_to profile_path, alert: "Помилка: Невірний ID платіжної сесії. #{e.message}"
    end
  end

  def show
      @order = current_user.orders.find(params[:id])
      @order_items = @order.order_items.includes(:item)
  rescue ActiveRecord::RecordNotFound
    redirect_to profile_path, alert: "Замовлення не знайдено."
  end

  private

  def order_params
    params.require(:order).permit(:full_name, :address, :phone, :payment_method)
  end
end
