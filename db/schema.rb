# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_12_12_111221) do
# Could not dump table "active_storage_attachments" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "active_storage_blobs" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "active_storage_variant_records" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "addresses" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "cart_items" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "carts" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "items" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "order_items" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "orders" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "payments" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "profiles" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "reviews" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "taggings" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "tags" because of following StandardError
#   Unknown type 'uuid' for column 'id'


# Could not dump table "users" because of following StandardError
#   Unknown type 'uuid' for column 'id'


  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "profiles"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "items"
  add_foreign_key "carts", "users"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "orders"
  add_foreign_key "profiles", "users"
  add_foreign_key "reviews", "items"
  add_foreign_key "reviews", "users"
  add_foreign_key "taggings", "items"
  add_foreign_key "taggings", "tags"
end
