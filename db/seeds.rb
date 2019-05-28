# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'
=begin
{
   "results":[
      {
         "gender":"female",
         "name":{
            "title":"miss",
            "first":"naja",
            "last":"mortensen"
         },
         "location":{
            "street":"2854 hulvejen",
            "city":"vipperød",
            "state":"syddanmark",
            "postcode":63560,
            "coordinates":{
               "latitude":"-36.7035",
               "longitude":"58.2444"
            },
            "timezone":{
               "offset":"+8:00",
               "description":"Beijing, Perth, Singapore, Hong Kong"
            }
         },
         "email":"naja.mortensen@example.com",
         "login":{
            "uuid":"b81d45ff-960f-4a82-b9e4-8abaeff05877",
            "username":"crazyleopard679",
            "password":"talon",
            "salt":"ya8OIjDJ",
            "md5":"b83c327a33353d466324946af773756a",
            "sha1":"63ed66a2a07b309ce872ad630a6c18da8c3ffa2e",
            "sha256":"0eb777aa58531c957df9c70af48c4ca72786ffb595a4b7d05e531538638a6664"
         },
         "dob":{
            "date":"1981-01-24T12:42:52Z",
            "age":38
         },
         "registered":{
            "date":"2012-11-19T12:58:22Z",
            "age":6
         },
         "phone":"99035445",
         "cell":"15401190",
         "id":{
            "name":"CPR",
            "value":"788558-7086"
         },
         "picture":{
            "large":"https://randomuser.me/api/portraits/women/90.jpg",
            "medium":"https://randomuser.me/api/portraits/med/women/90.jpg",
            "thumbnail":"https://randomuser.me/api/portraits/thumb/women/90.jpg"
         },
         "nat":"DK"
      }
   ],
   "info":{
      "seed":"7b49649df49c0ffd",
      "results":1,
      "page":1,
      "version":"1.2"
   }
}
=end

USER_API = 'https://randomuser.me/api/'

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

def random_user
  data = JSON.parse(URI.open("#{USER_API}").read)
  user = {}
  user[:first_name] = data["results"][0]["name"]["first"].capitalize
  user[:last_name] = data["results"][0]["name"]["last"].capitalize
  user[:photo] = data["results"][0]["picture"]["large"]
  user[:email] = data["results"][0]["email"]
  user
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
  user = random_user
  User.create(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: user[:email],
    photo: user[:photo],
    password: 'password123',
    city: Faker::Address.city,
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
