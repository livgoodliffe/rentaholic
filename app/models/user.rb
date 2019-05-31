class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :items
  has_many :bookings
  has_many :wishlists

  validates :first_name, presence: true
  validates :last_name, presence: true

  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_city?

  def wishlisted_item?(item)
    wishlists.where(item: item).any?
  end

  def find_favorite(item)
    wishlists.where(item: item).first
  end

  private

  def location
    "#{city} #{state} #{country}"
  end
end
