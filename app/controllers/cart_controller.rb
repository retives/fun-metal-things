class CartItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    @item = Item.find(params[:item_id])
    @cart = current_cart

    @cart_item = @cart.cart_items.find_or_initialize_by(item: @item)
    @cart_item.quantity += 1

    if @cart_item.save
      redirect_to items_path, notice: "Товар '#{@item.name}' додано до кошика!"
    else
      redirect_to item_path(@item), alert: "Не вдалося додати товар."
    end
  end
end
