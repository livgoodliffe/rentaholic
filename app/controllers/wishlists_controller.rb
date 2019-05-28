class WishlistsController < ApplicationController
  def index
    @wishlist = Wishlist.where(user: current_user)
  end
end
