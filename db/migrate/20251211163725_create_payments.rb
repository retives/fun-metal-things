class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments, id: :uuid do |t|
      t.decimal :total_price
      t.string :status
      t.string :transaction_reference

      t.timestamps
    end
  end
end
