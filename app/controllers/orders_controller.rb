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
    @order.save

    if @order.save
      redirect_to orders_path, notice: 'Pedido registrado com sucesso.'
    else
      flash[:alert] = 'Pedido não registrado. Confira o preenchimento.'
      render :new
    end
  end
end
