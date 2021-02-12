class Api::UsersController < ApplicationController
  before_action :user_all, only: [:index]
  before_action :user_find, only: [:show]

  def index
    render json: @users
  end

  def show
    render json: @user
  end

  private

  def user_find
    @user = user_all.find(params[:id])
  end

  def user_all
    @users = User.all
  end
end
