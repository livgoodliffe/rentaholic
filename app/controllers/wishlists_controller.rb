class WishlistsController < ApplicationController
  before_action :set_wishlist, only: :destroy
  before_action :set_item, only: :create

  def index
    @wishlist = Wishlist.where(user: current_user)
  end

  def create
    @wishlist = Wishlist.new
    @wishlist.user = current_user
    @wishlist.item = Item.find(params[:item_id])
    @wishlist.save
  end

  def destroy
    @wishlist.destroy

    redirect_to wishlists_path
  end

  private

  def set_wishlist
    @wishlist = Wishlist.find(params[:id])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def wishlist_params
    params.require(:wishlist).permit(:item_id)
  end
end
