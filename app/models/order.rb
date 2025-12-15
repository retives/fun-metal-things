class Order < ApplicationRecord
  # Зв'язки
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items
  has_one :payment, dependent: :destroy

  validates :full_name, :address, :phone, presence: true

  enum :status, {
    pending: "pending",
    processing: "processing",
    shipped: "shipped",
    delivered: "delivered",
    cancelled: "cancelled",
    paid: "paid"
  }, default: :pending

  def total_amount
    total_price
  end


  def calculate_total!
    self.total_price = order_items.sum { |oi| oi.quantity * oi.price_at_purchase }
    save!
  end
end
