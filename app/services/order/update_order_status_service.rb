class Order::UpdateOrderStatusService < Aldous::Service
  def initialize(id, params)
    @id = id
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
      find_order
      if @order && @order.update_attribute(:order_status, @params['order_status'])
        set_delivery_date
        Result::Success.new(order: @order)
      else
        Result::Failure.new(message: find_order.message, order: @order.errors)
      end
    end
  rescue => e
    Result::Failure.new(message: 'check update params', order: @order.errors)
  end

  private

  def find_order
    @order = Order.find_by_id(@id)
  rescue => e
    Result::Failure.new(message: e)
  end

  def set_delivery_date
    if @order.received?
      @order.delivery_date = DateTime.now
      @order.save
    end
  end
end