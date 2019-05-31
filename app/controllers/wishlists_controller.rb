class WishlistsController < ApplicationController
  before_action :set_wishlist, only: :destroy
  before_action :set_item, only: :create

  def index
    @wishlist = Wishlist.where(user: current_user)
  end

  def create
    @item = Item.find(params[:item_id])
    current_user.wishlists.create(item: @item)

    respond_to do |format|
      format.html { redirect_to @item }
      format.js
    end
    # redirect_to items_path(category: params[:category])

    # @wishlist = Wishlist.new
    # @wishlist.user = current_user
    # @wishlist.item = Item.find(params[:item_id])
    # @wishlist.save
  end

  def destroy
    wishlist = Wishlist.find(params[:id])
    @item = wishlist.item
    wishlist.destroy

    respond_to do |format|
      format.html { redirect_to @item }
      format.js { render :create }
    end
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
