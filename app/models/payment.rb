class Payment < ApplicationRecord
  belongs_to :order

  # Статуси оплати з правильним синтаксисом Rails 8
  enum :status, { 
    pending: 'pending', 
    completed: 'completed', 
    failed: 'failed' 
  }, default: :pending

  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :transaction_reference, presence: true, uniqueness: true

  before_validation :generate_test_reference, on: :create

  private

  def generate_test_reference
    self.transaction_reference ||= "TEST-PAY-#{SecureRandom.hex(8).upcase}"
  end
end