# app/controllers/cart_items_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!
  def show
    @cart = current_user.cart || current_user.create_cart

    @cart_items = @cart.cart_items.includes(:item)

    @total_price = @cart_items.sum { |ci| ci.quantity * ci.item.price }
  end
end
