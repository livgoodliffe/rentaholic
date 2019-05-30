class DashboardsController < ApplicationController
  def show
    # byebug
    @bookings = current_user.bookings

    if params[:booking_type] == 'current'
      @dash_view == 'current'
    elsif params[:booking_type] == 'wishlist'
      @dash_view == 'wishlist'
    elsif params[:booking_type] == 'my_items'
      @dash_view == 'my_items'
    else
      @dash_view == 'future'
    end

  end
end
