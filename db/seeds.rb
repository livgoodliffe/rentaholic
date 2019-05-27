# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'

PRODUCT_LIST_URL = 'https://www.randomlists.com/data/things.json'
PRODUCT_IMAGES_URL_BASE = 'https://www.randomlists.com/img/things/'
PRODUCT_NAMES = JSON.parse(URI.open(PRODUCT_LIST_URL).read)["RandL"]["items"]
PRODUCT_IMAGES = PRODUCT_NAMES.map { |product| "#{PRODUCT_IMAGES_URL_BASE}#{product.downcase.tr(' ', '_')}.jpg" }

PRODUCT_NAMES_CAPITALIZED = PRODUCT_NAMES.map { |product| product.split.map(&:capitalize).join(' ') }

LITERATURE_TEXT_URL_BASE = 'https://litipsum.com/api/'
LITERATURE_TEXTS = [ 'dracula',
                     'adventures-sherlock-holmes',
                     'dr-jekyll-and-mr-hyde',
                     'evelina',
                     'life-of-samuel-johnson',
                     'picture-of-dorian-gray',
                     'pride-and-prejudice']

def random_user_id
  User.find(rand(User.all.length) + 1).id
end

def random_item_id
  Item.find(rand(Item.all.length) + 1).id
end

def random_item_category
  Item::CATEGORIES.sample
end

def random_description
  URI.open("#{LITERATURE_TEXT_URL_BASE}#{LITERATURE_TEXTS.sample}/1").read
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

190.times do |n|
  puts "Item create #{n+1} out of 190"
  Item.create(
    user_id: random_user_id,
    name: PRODUCT_NAMES_CAPITALIZED[n],
    description: random_description,
    daily_rate: rand(1..1000),
    category: random_item_category,
    photo: PRODUCT_IMAGES[n]
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
