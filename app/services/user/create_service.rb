class User::CreateService < Aldous::Service
  attr_reader :user

  def initialize(params = {})
    @user = User.new(params)
  end

  def default_result_data
    { user: nil }
  end

  def raisable_error
    Aldous::Errors::UserError
  end

  def perform
    if @user.save
      Result::Success.new(user: @user)
    else 
      Result::Failure.new(user: @user)
    end
  rescue => e
    Result::Failure.new(user: @user)
  end
end