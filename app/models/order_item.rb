class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  before_create :set_price_at_purchase

  private

  def set_price_at_purchase
    self.price_at_purchase = item.price
  end
end