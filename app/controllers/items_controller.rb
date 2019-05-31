class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    if params[:search]
      @search = params[:search]
      @items = Item.where('name ILIKE ?', "%#{@search}%")
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
    @bookings_month = {}
    @booking_hash = create_booking_hash(params[:month])

    # geocoding
    @markers = [{ lng: @item.user.longitude, lat: @item.user.latitude }]
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

  def create_booking_hash(month_param)
    today = Date.today
    if month_param == nil
      year = today.year
      month = today.month
      month_start = Date.new(year, month, 1)
    else
      year = month_param[0..3].to_i
      month = month_param[5..6].to_i
      month_start = Date.new(year, month, 1)
    end
    last_day = month_start.end_of_month.day

    (0..(last_day - 1)).each do |n|
      @bookings_month[n] = {
        available: booking_availability(month_start + n.days),
        date: month_start + n.days
      }
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :photo, :daily_rate, :category)
  end
end
