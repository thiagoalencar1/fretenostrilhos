class OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(
      params.require(:order).permit(:distance, :status, :user_id, :carrier_id)
    )
  end
end
