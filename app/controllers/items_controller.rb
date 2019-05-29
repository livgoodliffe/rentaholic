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

  def show
    @item = Item.find(params[:id])
    @booking = Booking.new
    @bookings_week = {}
    @booking_hash = create_booking_hash(params[:weekstart])
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
    if week_start_date == nil
      week_start_date = Date.today
      7.times do |n|
        @bookings_week[n] = {
          available: booking_availability(week_start_date + n.days),
          date: week_start_date + n.days
        }
      end
    else
    end
  end
end
