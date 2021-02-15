class Order::CreateService < Aldous::Service
  attr_reader :order

  def initialize(params = {})
    @params = params
  end

  def default_result_data
    { order: nil }
  end

  def raisable_error
    Aldous::Errors::OrderError
  end

  def perform
    Order.transaction do
      @order = Order.new(@params)
      
      if @order.save
        Result::Success.new(order: @order)
      else
        Result::Failure.new(order: @order)
      end
    end
  rescue => e
    Result::Failure.new(message: e)
  end
end