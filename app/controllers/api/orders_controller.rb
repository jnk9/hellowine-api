class Api::OrdersController < ApplicationController
  before_action :orders_all, only: [:index]
  before_action :order_find, only: [:show]

  def index
    render json: @orders
  end

  def show
    render json: @order
  end

  def create
    create_service = Order::CreateService.new(order_create_params)
    result = create_service.perform
    @order = result.order

    if result.success?
      render json: {order: @order}
    else
      render json: { message: @order.errors }, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def update_order_status 
    update_service = Order::UpdateOrderStatusService.new(params[:id], order_update_params)
    result = update_service.perform
    @order = result.order

    if result.success?
      render json: @order
    else
      render json: {state: :error, message: result._data}, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def update_payment_status 
    update_service = Order::UpdatePaymentStatusService.new(params[:id], order_update_params)
    result = update_service.perform
    @order = result.order

    if result.success?
      render json: @order
    else
      render json: {message: result._data}, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def destroy
    delete_service = Order::DeleteService.new(params[:id])
    result = delete_service.perform

    if result.success?
      render json: { message: 'Order deleted successfully'}
    else
      render json: {state: :error, message: result._data}, status: :bad_request
    end

  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  private

  def orders_all
    @orders = apply_scopes(Order)
  end

  def apply_scopes(object)
    if params['date'].present?
      date = Date.parse(params['date'])
      object
        .by_delivery_date_day(date)
        .by_delivery_date_month(date)
        .by_delivery_date_year(date)
    else
      object.all
    end
  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def order_find
    @order = orders_all.find_by_id(params[:id])
  rescue StandardError => e
    render json: { state: :error, message: e.message }, status: :bad_request
  end

  def order_create_params
    params.require(:order).permit(Order.allowed_attributes_create)
  end

  def order_update_params
    params.require(:order).permit(Order.allowed_attributes_update)
  end
end