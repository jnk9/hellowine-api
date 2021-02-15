class Order::UpdatePaymentStatusService < Aldous::Service
  attr_reader :order

  def initialize(id, params)
    @id = id
    @params = params
  end

  def perform
    Order.transaction do
      find_order
      if @order.update_attribute(:payment_status, @params['payment_status'])
        set_payment_date
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
  rescue => e
    Result::Failure.new(message: e)
  end

  def set_payment_date
    if order.paid?
      order.payment_date = DateTime.now
      @order.save
    end
  end
end
