module ApplicationHelper
  def order_status_color(status)
    case status&.downcase
    when "paid"
      "text-green-500 border-green-900/50 bg-green-900/10"
    when "pending"
      "text-amber-500 border-amber-900/50 bg-amber-900/10"
    when "shipped"
      "text-primary border-primary/30 bg-primary/10"
    else
      "text-stone-400 border-stone-700 bg-stone-800"
    end
  end
end
