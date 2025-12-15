# app/controllers/admin/items_controller.rb
class Admin::ItemsController < Admin::BaseController
  # Цей фільтр шукає товар перед виконанням edit, update та destroy
  before_action :set_item, only: [ :edit, :update, :destroy ]

  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_items_path, notice: "Товар успішно створено! 🎸"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @item вже встановлено через before_action
  end

  def update
    if @item.update(item_params)
      redirect_to admin_items_path, notice: "Товар оновлено! 🤘"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to admin_items_path, notice: "Товар видалено з бази. 🗑️"
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :quantity, tag_ids: [])
  end
end
