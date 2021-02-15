class User::DeleteService < Aldous::Service
  attr_reader :user, :message

  def initialize(id)
    @id = id
  end

  def default_result_data
    { user: nil, message: nil }
  end

  def raisable_error
    Aldous::Errors::UserError
  end

  def perform
    find_user

    if @user && @user.destroy
      Result::Success.new(user: @user)
    else 
      Result::Failure.new(message: find_user.message)
    end
  rescue => e
    Result::Failure.new(user: @user, message: e)
  end

  private

  def find_user
    @user = User.find_by_id(@id)
    Result::Failure.new(message: 'user not found') unless @user
  rescue => e
    Result::Failure.new(user: @user, message: e)
  end
end