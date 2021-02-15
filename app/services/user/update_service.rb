class User::UpdateService < Aldous::Service
  attr_reader :user

  def initialize(id, params = {})
    @id = id
    @params = params
  end

  def default_result_data
    { user: nil }
  end

  def raisable_error
    Aldous::Errors::UserError
  end

  def perform
    find_user
    if @user.update_attributes(@params)
      Result::Success.new(user: @user)
    else 
      Result::Failure.new(user: @user)
    end
  rescue => e
    Result::Failure.new(user: @user)
  end

  private

  def find_user
    @user = User.find(@id)
    Result::Failure.new(user: @user) unless @user
  rescue => e
    Result::Failure.new(user: @user)
  end
end