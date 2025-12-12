class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.decimal :total_price
      t.string :status
      t.references :user, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
