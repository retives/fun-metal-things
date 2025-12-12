class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy [cite: 263]
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy [cite: 265]
  has_many :reviews, dependent: :destroy [cite: 191]

  enum role: { client: 'client', admin: 'admin' }

  after_create :create_user_dependencies

  private

  def create_user_dependencies
    create_profile [cite: 263]
    create_cart
  end
end