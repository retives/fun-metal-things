# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# 1. Очищення бази даних (щоб уникнути дублікатів при повторному запуску)
puts "Cleaning database..."
[OrderItem, Order, Payment, CartItem, Cart, Review, Tagging, Tag, Item, Address, Profile, User].each(&:delete_all)

# 2. Створення користувачів та профілів [cite: 101, 103, 104, 262]
puts "Creating Users..."

admin = User.create!(
  email: 'admin@funmetalthings.com',
  password: 'password123',
  role: 'admin'
)
admin.profile.update!(first_name: 'Metal', last_name: 'Admin', phone_number: '+380990000001')

client = User.create!(
  email: 'fan@metalcore.ua',
  password: 'password123',
  role: 'client'
)
client.profile.update!(first_name: 'Alex', last_name: 'Riffer', phone_number: '+380990000002')

# 3. Створення категорій (Тегів) [cite: 171, 173]
puts "Creating Categories..."
categories = ['Гітари', 'Барабани', 'Акустичні гітари', 'Мерч', 'Клавішні', 'Аксесуари'].map do |name|
  Tag.create!(name: name)
end

# 4. Створення товарів (Items) з фокусом на металкор [cite: 48, 60, 61, 158]
puts "Creating Items..."

# Гітари
guitars = [
  { name: 'ESP LTD EC-1000VB', price: 42000, quantity: 5, description: 'Легендарна гітара для важких рифів.' },
  { name: 'Schecter Hellraiser C-1', price: 38500, quantity: 3, description: 'Активні звукознімачі EMG для металу.' },
  { name: 'Ibanez Iron Label RG', price: 35000, quantity: 4, description: 'Створена спеціально для металу.' }
].map { |data| Item.create!(data.merge(is_available: true)) }
guitars.each { |i| i.tags << Tag.find_by(name: 'Гітари') }

# Мерч
merch = [
  { name: 'Parkway Drive Hoodie', price: 1800, quantity: 20, description: 'Чорне худі з логотипом гурту.' },
  { name: 'Architects T-Shirt "Holy Hell"', price: 850, quantity: 15, description: 'Футболка з якісним принтом.' },
  { name: 'Bring Me The Horizon Beanie', price: 600, quantity: 10, description: 'Тепла шапка для справжніх фанів.' }
].map { |data| Item.create!(data.merge(is_available: true)) }
merch.each { |i| i.tags << Tag.find_by(name: 'Мерч') }

# Барабани та аксесуари (скорочено для прикладу)
drums = Item.create!(name: 'Tama Speed Cobra 910', price: 15000, quantity: 2, description: 'Подвійна педаль для екстремальної швидкості.', is_available: true)
drums.tags << Tag.find_by(name: 'Барабани')


# 7. Відгуки (Reviews) [cite: 75, 191, 194]
puts "Creating Reviews..."
Review.create!(
  user: client,
  item: guitars.first,
  rating: 5,
  details: "Найкраща гітара для металкору! Звук просто стіна."
)

# 8. Адреса [cite: 264]
Address.create!(
  profile: client.profile,
  city: 'Kyiv',
  street: 'Metal Street',
  house_number: '666',
  zip_code: '01001'
)

puts "Seeds finished! Ready to rock. \m/"