class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.integer :rating
      t.text :details
      t.references :user, type: :uuid, foreign_key: true
      t.references :item, type: :uuid, foreign_key: true

      t.timestamps
    end
  end
end
