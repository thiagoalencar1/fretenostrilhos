class OrdersController < ApplicationController
  before_action :authenticate_admin!, only: %i[index new create budgets]

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

  def search
    @order_number = params['query']
    @order = Order.find_by(order_number: @order_number)
  end

  def budgets
    @carriers = Carrier.where(status: :active)
  end
end
