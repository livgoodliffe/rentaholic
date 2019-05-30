class DashboardsController < ApplicationController
  def show
    # byebug

    # if params[:booking_type] == 'current'
    # get all bookings that have a start date before today
    # and an end date after or including today
    # save to @dash_view, use in the view
    @bookings = current_user.bookings

    @current_user = current_user
  # end


  end
end
