class CreateOrderItems < ActiveRecord::Migration[7.0]
  def change
    create_table :order_items, id: :uuid do |t|
      t.references :order, null: false, foreign_key: true, type: :uuid
      t.references :item, null: false, foreign_key: true, type: :uuid
      t.integer :quantity, null: false, default: 1
      t.decimal :price_at_purchase, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end