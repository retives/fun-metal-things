# rails generate migration CreateCarts
class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid # null: true для гостей
      t.timestamps
    end

    create_table :cart_items, id: :uuid do |t|
      t.references :cart, null: false, foreign_key: true, type: :uuid
      t.references :item, null: false, foreign_key: true, type: :uuid
      t.integer :quantity, default: 1
      t.timestamps
    end
  end
end