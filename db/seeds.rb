# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'
require 'open-uri'
require 'nokogiri'

USER_API = 'https://randomuser.me/api/'

def cleanup_user_descriptions(descriptions)
  descriptions.map do |description|
    description.text.delete('"').gsub(/^\d+\. /,'')
  end
end

USER_DESCRIPTION_URL = 'https://www.fakepersongenerator.com/user-biography-generator'
USER_DESCRIPTIONS = cleanup_user_descriptions(Nokogiri::HTML(open(USER_DESCRIPTION_URL)).css(".row p"))
USER_LOCATIONS = [
  'East Melbourne',
  'South Yarra',
  'Toorak',
  'Armadale',
  'Melbourne',
  'Elsternwick',
  'Albert Park',
  'Ivanhoe',
  'Parkville',
  'North Melbourne',
  'Clifton Hill',
  'Balaclava',
  'Fairfield',
  'St Kilda East',
  'Carlton'
]

ITEM_LIST_URL = 'https://www.randomlists.com/data/things.json'
ITEM_IMAGES_URL_BASE = 'https://www.randomlists.com/img/things/'
ITEM_NAMES = JSON.parse(URI.open(ITEM_LIST_URL).read)["RandL"]["items"]
ITEM_IMAGES = ITEM_NAMES.map { |item| "#{ITEM_IMAGES_URL_BASE}#{item.downcase.tr(' ', '_')}.jpg" }

ITEM_NAMES_CAPITALIZED = ITEM_NAMES.map { |item| item.split.map(&:capitalize).join(' ') }

WIKIPEDIA_TEXT_URL_BASE = 'https://en.wikipedia.org/wiki/'

def random_user_id
  User.find(rand(User.all.length) + 1).id
end

def random_user(n)
  user = {}
  data = JSON.parse(URI.open("#{USER_API}").read)["results"][0]
  if data["gender"] == 'male'
    first_name = Faker::Name.male_first_name
  else
    first_name = Faker::Name.female_first_name
  end
  last_name =   Faker::Name.last_name
  user[:first_name] = first_name
  user[:last_name] = last_name
  user[:photo] = data["picture"]["large"]
  user[:email] = "#{first_name.downcase}.#{last_name.downcase}@example.org"
  user[:description] = USER_DESCRIPTIONS[n]
  user
end

def random_item_id
  Item.find(rand(Item.all.length) + 1).id
end

def random_item_category
  Item::CATEGORIES.sample
end

def random_item_description
  URI.open("#{LITERATURE_TEXT_URL_BASE}#{LITERATURE_TEXTS.sample}/1").read
end

def item_description(item_name)
  # name changes to assist with wikipedia search
  replacements = {
    'buckel' => 'buckle',
    'candy wrapper' => 'candy',
    'soy sauce packet'=> 'soy sauce',
    'outlet' => 'power socket',
    'plastic fork' => 'fork',
    'pool stick'=> 'cue stick',
    'sketch pad'=> 'notebook',
    'twezzers'=> 'tweezers',
    'bow'=> 'bow tie',
    'drawer'=> 'chest of drawers',
    'keyboard'=> 'computer keyboard',
    'key'=> 'key (lock)',
    'table'=> 'table (furniture)',
    'cork'=> 'cork (plug)',
    'hanger'=> 'clothes hanger',
    'charger'=> 'power adapter',
    'lamp'=> 'desk lamp',
    'monitor'=> 'computer monitor',
    'needle'=> 'sewing needle',
    'plate'=> 'plate (dishware)',
    'purse'=> 'handbag',
    'remote'=> 'remote control',
    'ring'=> 'ring (jewellery)',
    'rug'=> 'carpet',
    'sharpie'=> 'marker pen',
    'speakers'=> 'loudspeaker',
    'spring'=> 'spring (device)',
    'thread'=> 'thread (yarn)',
    'twister'=> 'twister (game)',
    'clamp'=> 'clamp (tool)',
    'white out'=> 'correction fluid',
    'controller'=> 'game controller'
  }

  item_name = replacements[item_name] if replacements.key?(item_name)
  item_name_adjusted = item_name.downcase.capitalize.tr(' ', '_')
  Nokogiri::HTML(open("#{WIKIPEDIA_TEXT_URL_BASE}#{item_name_adjusted}")).css(".mw-parser-output p").text.truncate_words(100).gsub(/\[\d+\]/,'').strip
end

def item_name_fixup(item_name)
  item_name
end

def random_booking_period
  date_format = '%Y-%m-%d'
  start_date = Date.today() - 15 + rand(1..30).days
  end_date = start_date + rand(1..7).days
  [start_date.strftime(date_format), end_date.strftime(date_format)]
end


15.times do |n|
  puts "User created (#{n+1}/15) #{((n+1).fdiv(15)*100).to_i}%"
  user = random_user(n)
  User.create(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: user[:email],
    photo: user[:photo],
    description: user[:description],
    password: 'password123',
    city: USER_LOCATIONS[n],
  );
end

190.times do |n|
  puts "Item created (#{n+1}/190) #{((n+1).fdiv(190)*100).to_i}%"
  i = Item.new(
    user_id: random_user_id,
    name: item_name_fixup(ITEM_NAMES_CAPITALIZED[n]),
    description: item_description(ITEM_NAMES[n]),
    daily_rate: rand(1..1000),
    category: random_item_category,
  )
  i.remote_photo_url = ITEM_IMAGES[n]
  i.save
end

200.times do |n|
  puts "Booking created (#{n+1}/200) #{((n+1).fdiv(200)*100).to_i}%"
  dates = random_booking_period
  Booking.create(
    user_id: random_user_id,
    item_id: n+1,
    start_date: dates.first,
    end_date: dates.last,
    daily_rate: rand(1..1000)
  )
end
