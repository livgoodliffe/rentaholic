class BookingsController < ApplicationController
  def show
  end

  def new
    @item = Item.find(params[:item_id])
    @booking = Booking.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
