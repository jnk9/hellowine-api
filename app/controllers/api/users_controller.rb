class Api::UsersController < ApplicationController
  before_action :user_all, only: [:index]

  def index
    render json: @users
  end

  private

  def user_all
    @users = User.all
  end
end
