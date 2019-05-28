class WishlistsController < ApplicationController
  def index
    @wishlist = Wishlist.where(user_id: current_user.id)
  end
end
