class Api::UsersController < ApplicationController
  before_action :user_all, only: [:index]
  before_action :user_find, only: [:show]

  def index
    render json: @users
  end

  def show
    render json: @user
  end

  def create
    create_service = User::CreateService.new(
      { 
        email: params[:email], 
        name: params[:name]
      }
    )

    result = create_service.perform
    @user = result.user

    if result.success?
      render json: @user
    else
      render json: {message: @user.errors}, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def update
    update_service = User::UpdateService.new(params['id'], user_params_params)

    result = update_service.perform
    @user = result.user

    if result.success?
      render json: @user
    else
      render json: {message: @user.errors}, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  private

  def user_params_params
    params.require(:user).permit(User.allowed_attributes_update)
  end

  def user_find
    @user = user_all.find(params[:id])
  end

  def user_all
    @users = User.all
  end
end
