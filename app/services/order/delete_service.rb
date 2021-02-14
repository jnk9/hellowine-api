class Order::DeleteService < Aldous::Service
  attr_reader :order

  def initialize(id)
    @id = id
  end

  def default_result_data
    { order: nil }
  end

  def raisable_error
    Aldous::Errors::OrderError
  end

  def perform
    Order.transaction do
      find_order
      
      if @order && @order.destroy
        Result::Success.new(order: @order)
      else
        Result::Failure.new(message: find_order.message)
      end
    end
  rescue => e
    Result::Failure.new(message: e)
  end

  private 

  def find_order
    @order = Order.find_by_id(@id)
    Result::Failure.new(message: 'order not found') unless @order
  rescue => e
    Result::Failure.new(order: @order, message: e)
  end
end