class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:search]
      @search = params[:search].capitalize
      @items = Item.where('name LIKE ?', "%#{@search}%")
    else
      category = params[:category]
      if Item::CATEGORIES.include? (category)
        @items = Item.where(category: category)
        @category = category
      end
    end
  end


  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    if @item.save
      flash[:notice] = "Item was saved."
      redirect_to @item
    else
      flash[:error] = "There was an error saving the item. Please try again."
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])

    # booking code
    @booking = Booking.new
    @bookings_week = {}
    @booking_hash = create_booking_hash(params[:weekstart])

    # geocoding
    @coordinates = [@item.user.longitude, @item.user.latitude]
    @users = User.where(latitude: nil)
    nil_location = @users.map { |user| user.id }
    @items = Item.where.not(user_id: nil_location)
    @markers = @items.map { |item| { lat: item.user.latitude, lng: item.user.longitude } }
  end

  private

  def booking_availability(date)
    @item.bookings.each do |booking|
      days = (booking.end_date - booking.start_date).to_i
      days.times do |n|
        return false if booking.start_date + n.days == date
      end
    end
    true
  end

  def create_booking_hash(week_start_date)
    # in progress (will implement buttons later)
    if week_start_date == nil
      week_start_date = Date.today
    else
      year = week_start_date[0..3].to_i
      month = week_start_date[5..6].to_i
      day = week_start_date[8..9].to_i
      week_start_date = Date.new(year, month, day)
    end
    7.times do |n|
      @bookings_week[n] = {
        available: booking_availability(week_start_date + n.days),
        date: week_start_date + n.days
      }
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :photo, :daily_rate, :category)
  end
end
