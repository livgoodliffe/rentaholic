class Item < ApplicationRecord

  CATEGORIES = [
    "Clothing",
    "Technology",
    "Vehicles",
    "Office Supplies",
    "Gardening Tools",
    "Boats",
    "Toys",
    "Games",
    "Furniture"
  ].freeze

  belongs_to :user

  validates :daily_rate, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
end
