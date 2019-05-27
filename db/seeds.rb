# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
=begin
 create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "item_id"
    t.integer "daily_rate"
    t.date "start_date"
    t.date "end_date"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_bookings_on_item_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo"
    t.integer "daily_rate"
    t.bigint "user_id"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
=end

require 'faker'
require 'open-uri'

NOUN_API='http://names.drycodes.com/1'
PHOTO_API='https://picsum.photos/800/800'


def random_user_id
  User.find(rand(User.all.length) + 1).id
end

def random_item_id
  Item.find(rand(Item.all.length) + 1).id
end

def random_item_category
  Item::CATEGORIES[rand(Item::CATEGORIES.length)]
end

def random_booking_period
  date_format = '%Y-%m-%d'
  start_date = Date.today() + rand(1..30).days
  end_date = start_date + rand(1..7).days
  [start_date.strftime(date_format), end_date.strftime(date_format)]
end

10.times do |n|
  puts "User create #{n+1} out of 10"
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password123',
    city: rand > 0.5 ? Faker::Address.city : '',
  );
end

100.times do |n|
  puts "Item create #{n+1} out of 100"
  Item.create(
    user_id: random_user_id,
    name: JSON.parse(URI.open(NOUN_API).read).first,
    description: Faker::Lorem.paragraph(2, true, 4),
    daily_rate: rand(1..1000),
    category: random_item_category,
    photo: "#{PHOTO_API}?r=#{rand}"
  )
end

100.times do |n|
  puts "Booking create #{n+1} out of 100"
  dates = random_booking_period
  Booking.create(
    user_id: random_user_id,
    item_id: n+1,
    start_date: dates.first,
    end_date: dates.last,
    daily_rate: rand(1..1000)
  )
end
