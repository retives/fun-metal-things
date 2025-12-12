class Order < ApplicationRecord
  # Зв'язки
  belongs_to :user 
  has_many :order_items, dependent: :destroy
  has_one :payment, dependent: :destroy 

  # Статуси замовлення
  enum :status, { 
    pending: 'pending', 
    processing: 'processing', 
    shipped: 'shipped', 
    delivered: 'delivered',
    cancelled: 'cancelled'
  }, default: :pending
end