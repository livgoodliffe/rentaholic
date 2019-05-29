class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    # byebug
    if params[:search]
      @search = params[:search].capitalize
      @items = Item.where('name LIKE ?', "%#{@search}%")

      # byebug
    else
      category = params[:category]
      if Item::CATEGORIES.include? (category)
        @items = Item.where(category: category)
        @category = category
      end
    end
  end

  def show
    @item = Item.find(params[:id])
    @booking = Booking.new

    @coordinates = [@item.user.longitude, @item.user.latitude]

    @users = User.where(latitude: nil)
    nil_location = @users.map { |user| user.id }
    @items = Item.where.not(user_id: nil_location)

    @markers = @items.map { |item| { lat: item.user.latitude, lng: item.user.longitude } }
  end
end
