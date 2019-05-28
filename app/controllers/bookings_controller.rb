class BookingsController < ApplicationController
  def show
  end

  def new
    @item = Item.find(params[:item_id])
    @booking = Booking.new
  end

  def create
    @errors = {}
    @booking = Booking.new(booking_params)
    @item = Item.find(params[:item_id])
    @booking.item = @item
    @booking.user = current_user
    @booking.daily_rate = @item.daily_rate
    if dates_validation? && @booking.save
      flash[:notice] = "Booking Created"
      redirect_to @booking.item
    else
      flash[:alert] = "Booking Invalid"
      render "items/show"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def dates_validation?
    (@booking.end_date - @booking.start_date).to_i > 0 && (@booking.start_date - Date.today()).to_i >= 0
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
