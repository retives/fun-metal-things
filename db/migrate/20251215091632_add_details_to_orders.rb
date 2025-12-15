class AddDetailsToOrders < ActiveRecord::Migration[8.0]
  def change
    add_column :orders, :full_name, :string
    add_column :orders, :phone, :string
    add_column :orders, :address, :text
    add_column :orders, :payment_method, :string
    add_column :orders, :stripe_session_id, :string
  end
end
