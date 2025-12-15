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
            # price: ci.item.price_at_purchase
          )

          item = ci.item
          new_quantity = item.quantity - ci.quantity

          if new_quantity < 0
            raise ActiveRecord::Rollback, "Недостатньо товару #{item.name} на складі"
          end

          item.update!(quantity: new_quantity)
        end

        @cart.cart_items.destroy_all

        redirect_to order_path(@order), notice: "Замовлення успішно оформлено! Готуйте підсилювачі! 🎸"
      else
        render :new, status: :unprocessable_entity
      end
    end
  rescue ActiveRecord::Rollback => e
    redirect_to cart_path, alert: e.message
  end

  private

  def order_params
    params.require(:order).permit(:full_name, :address, :phone, :payment_method)
  end

def payment
  @order = Order.find(params[:id])
  @cart = current_user.cart
  if @order.nil?
    redirect_to profile_path, alert: "Замовлення не знайдено або ви не маєте до нього доступу."
    return
  end
  if @order.paid?
    redirect_to order_path(@order), notice: "Це замовлення вже оплачено! 🤘"
    return
  end
  # Створюємо сесію Stripe
  @session = Stripe::Checkout::Session.create({
    customer_email: current_user.email,
    payment_method_types: [ "card" ],
    line_items: @cart.cart_items.map do |ci|
      {
        price_data: {
          currency: "uah",
          product_data: { name: ci.item.name },
          unit_amount: (ci.item.price * 100).to_i
        },
        quantity: ci.quantity
      }
    end,
    mode: "payment",
    success_url: confirm_payment_order_url(@order) + "?session_id={CHECKOUT_SESSION_ID}",
    cancel_url: cart_url
  })


  @order.update(stripe_session_id: @session.id)
end

  def confirm_payment
    @order = Order.find(params[:id])
    @cart = current_user.cart

    ActiveRecord::Base.transaction do
      # Списання товару (Вимога 3.1.2)
      @cart.cart_items.each do |ci|
        OrderItem.create!(order: @order, item: ci.item, quantity: ci.quantity, price: ci.item.price)
        ci.item.update!(quantity: ci.item.quantity - ci.quantity)
      end

      @order.update!(status: "paid")
      @cart.cart_items.destroy_all
    end

    redirect_to order_path(@order), notice: "Оплата пройшла успішно! 🤘"
  end

  def show
    @order = current_user.orders.find(params[:id])
    @order_items = @order.order_items.includes(:item)
  end
end
