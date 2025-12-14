class CartItemsController < ApplicationController
  before_action :authenticate_user!

def create
  @item = Item.find(params[:item_id])
  @cart = current_user.cart || current_user.create_cart

  ActiveRecord::Base.transaction do
    @cart_item = @cart.cart_items.find_or_initialize_by(item_id: @item.id)

    if @cart_item.new_record?
      @cart_item.quantity = 1
    else
      @cart_item.quantity += 1
    end

    @cart_item.save!
  end

  redirect_to cart_path, notice: "Товар додано! 🤘"
rescue ActiveRecord::RecordInvalid
  redirect_to item_path(@item), alert: "Помилка при додаванні."
end
  def destroy
    @cart_item = current_user.cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path, notice: "Товар вилучено з кошика."
  end

  def update
    @cart_item = current_user.cart.cart_items.find(params[:id])

    # Визначаємо нову кількість на основі натиснутої кнопки
    case params[:operation]
    when "increment"
      @cart_item.quantity += 1
    when "decrement"
      @cart_item.quantity -= 1 if @cart_item.quantity > 1
    end

    if @cart_item.save
      redirect_to cart_path, notice: "Кількість оновлено."
    else
      redirect_to cart_path, alert: "Не вдалося оновити кількість."
    end
  end
end
