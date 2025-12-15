class Admin::OrdersController < Admin::BaseController
  def index
    @orders = Order.includes(:user).all.order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.includes(:item)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to admin_orders_path, notice: "Статус замовлення №#{@order.id.to_s.first(8)} оновлено! 🤘"
    else
      redirect_to admin_orders_path, alert: "Не вдалося оновити статус."
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
