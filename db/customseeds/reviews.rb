# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

Review.destroy_all

PAST_BOOKINGS = Booking.where("end_date < ?", Date.today)

def random_user_id
  User.find(rand(User.count) + 1).id
end

PAST_BOOKINGS.count.times do |n|
  puts "Review created (#{n+1}/#{PAST_BOOKINGS.count}) #{((n+1).fdiv(PAST_BOOKINGS.count)*100).to_i}%"
  Review.create(
    booking_id: PAST_BOOKINGS[n][:id],
    content: Faker::Lorem.sentence(3, false, 12),
    stars: Review::STARS.sample,
  )
end
