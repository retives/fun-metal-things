class Profile < ApplicationRecord
  belongs_to :user
  has_many :addresses, dependent: :destroy

  validates :first_name, :last_name, presence: true, on: :update
  validates :phone_number, format: { with: /\A\+?\d{10,15}\z/ }, allow_blank: true
end