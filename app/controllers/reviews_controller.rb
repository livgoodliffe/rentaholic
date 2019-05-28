class ReviewsController < ApplicationController
  before_action :set_booking, only: [:create]

  def create
    @review = Review.new(review_params)

    @review.booking = @booking

    if @review.save
      redirect_to @booking, notice: 'Review was successfully added.'
    else
      render 'item/show'
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :stars)
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end
end
