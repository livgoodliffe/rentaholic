class WishlistsController < ApplicationController
  def index
    @wishlist = Wishlist.where(user: current_user)
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy

    redirect_to wishlists_path
  end
end
