class ItemsController < ApplicationController
  def index
    @items = Item.where("quantity > 0").order(created_at: :desc)

    if params[:tag].present?
      @items = @items.joins(:tags).where(tags: { name: params[:tag] })
    end
  end
  def show
    @item = Item.find(params[:id])
  end
end
