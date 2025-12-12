class Review < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :details, presence: true, length: { minimum: 5 }

  validates :user_id, uniqueness: { scope: :item_id, message: "ви вже залишили відгук до цього товару" }
end