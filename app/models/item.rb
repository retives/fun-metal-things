class Item < ApplicationRecord
  has_one_attached :image


  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :reviews, dependent: :destroy
  has_many :order_items

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_save :update_availability_status

  private

  def update_availability_status
    self.is_available = quantity > 0
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "description", "price", "created_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "tags" ]
  end
end
