class Profile < ApplicationRecord
  belongs_to :user
  has_many :addresses, dependent: :destroy

validates :first_name, :last_name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :phone_number, presence: true, format: { with: /\A\+?\d{10,15}\z/, message: "має бути у форматі +380XXXXXXXXX" }
end
