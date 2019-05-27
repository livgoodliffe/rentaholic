class Item < ApplicationRecord
  CATEGORIES = [
    "Technology",
    "Sporting Goods",
    "Baby & Children",
    "Home & Garden",
    "Fashion",
    "Vehicles",
    "Office",
    "Games",
    "Furniture"
  ].freeze


  belongs_to :user
  belongs_to :bookings

  validates :daily_rate, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
