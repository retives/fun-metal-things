class CreateProfilesAndAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.timestamps
    end

    create_table :addresses, id: :uuid do |t|
      t.references :profile, null: false, foreign_key: true, type: :uuid
      t.string :city
      t.string :street
      t.string :house_number
      t.string :zip_code
      t.boolean :is_default, default: false
      t.timestamps
    end
  end
end