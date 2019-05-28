class Item < ApplicationRecord
  CATEGORIES = [
    "Clothing",
    "Technology",
    "Vehicles",
    "Office",
    "Home and Garden",
    "Entertainment"
  ].freeze

  belongs_to :user
  has_many :bookings

  validates :daily_rate, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
