class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_one :cart, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :reviews, dependent: :destroy

  enum :role, { client: "client", admin: "admin" }, default: "client"

  after_create :create_user_dependencies

  def admin?
    role == "admin"
  end

  private

  def create_user_dependencies
    create_profile
    create_cart
  end
end
