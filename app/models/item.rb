class Item < ApplicationRecord
  CATEGORIES = [
    "Clothing",
    "Technology",
    "Vehicles",
    "Office",
    "Home and Garden",
    "Entertainment"
  ].freeze

  mount_uploader :photo, PhotoUploader

  belongs_to :user
  has_many :bookings, dependent: :destroy

  validates :daily_rate, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true, inclusion: { in: CATEGORIES }
  validates :photo, presence: true
end
