class WishlistsController < ApplicationController
  def index
    @wishlist = Wishlist.where(user: current_user)
  end

  def destroy
    @wishlist = Wishlist.find(params[:id])
    @wishlist.destroy

    redirect_to wishlists_path
  end

  def new

    @wishlist = Wishlist.new
    create
  end

  def create
    @wishlist.user = current_user
    @wishlist.item = Item.find(params[:item])
    @wishlist.save
    # byebug
    redirect_to wishlists_path
  end
end
