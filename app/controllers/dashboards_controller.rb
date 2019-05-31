class DashboardsController < ApplicationController
  def show
    if params[:booking_type] == 'current'
      @dash_view = 'current'
      @bookings = current_bookings
    elsif params[:booking_type] == 'past'
      @review = Review.new
      @dash_view = 'past'
      @bookings = past_bookings
    elsif params[:booking_type] == 'wishlist'
      @wishlists = current_user.wishlists
      @dash_view = 'wishlist'
      @wishlist
    elsif params[:booking_type] == 'my_items'
      @dash_view = 'my_items'
    else
      @dash_view = 'future'
      @bookings = future_bookings
    end
  end

  private


  def future_bookings
    current_user.bookings.select{|booking| booking.start_date > Date.today}
  end

  def current_bookings
    current_user.bookings.select{|booking| booking.start_date<= Date.today && booking.end_date >= Date.today}
  end

  def past_bookings
    current_user.bookings.select{|booking| booking.end_date < Date.today}
  end
end
