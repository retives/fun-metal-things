class Address < ApplicationRecord
  belongs_to :profile

  validates :city, :street, :house_number, presence: true
end