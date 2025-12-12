class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews, id: :uuid do |t|
      t.integer :rating
      t.text :details
      t.datetime :created_at

      t.timestamps
    end
  end
end
