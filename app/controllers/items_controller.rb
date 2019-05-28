class ItemsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    # byebug
    if params[:search]
      @items = Item.where('name LIKE ?', "%#{params[:search]}%")
      @search = params[:search]
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
  end
end
