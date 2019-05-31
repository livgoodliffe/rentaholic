class Wishlist < ApplicationRecord
  belongs_to :user
  belongs_to :item

  validates :user, uniqueness: { scope: :item, message: "has already added this item"}
end
