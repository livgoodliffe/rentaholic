class UsersController < ApplicationController
  def show
    @current_user = current_user
    @params = params
  end
end
