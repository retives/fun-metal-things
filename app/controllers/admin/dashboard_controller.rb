class Admin::DashboardController < Admin::BaseController
  def index
    @orders_count = Order.count
    @total_revenue = Order.where(status: "paid").sum(:total_price)
    @recent_orders = Order.order(created_at: :desc).limit(5)
  end
end
