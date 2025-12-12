class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items, id: :uuid do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.integer :quantity
      t.boolean :is_available

      t.timestamps
    end
  end
end
