class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :daily_rate, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
