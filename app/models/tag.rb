class Tag < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :items, through: :taggings

  validates :name, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "created_at" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "items" ]
  end
end
