class OrdersController < ApplicationController
  before_action :authenticate_admin!, only: %i[new create budgets]

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @tracking_logs = TrackingLog.where(order_id: @order.id)
  end

  def new
    @order = Order.new
    @carriers = Carrier.active
  end

  def create
    # @carriers = Carrier.active
    @order = Order.new(params.require(:order).permit(
                         :order_number, :order_value, :distance, :package_weight, :package_volume,
                         :origin_address, :destiny_address, :carrier_id, :delivery_date
                       ))
    @carrier = Carrier.find(params[:order][:carrier_id])
    @volume = params[:package_volume].to_f
    @weight = params[:package_weight].to_f
    @distance = params[:distance].to_i
    @order.order_value = get_order_value(@volume, @weight, @distance, @carrier.id)
    @order.delivery_date = get_delivery_date(@distance, @carrier.id)
    @order.save!

    if @order.save
      redirect_to @order, notice: 'Pedido registrado com sucesso.'
    else
      flash.now[:alert] = 'Pedido não registrado. Confira o preenchimento.'
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
    @carriers = Carrier.active
  end

  def update
    order_params = params.require(:order).permit(
      :warehouse_id, :supplier_id, :estimated_delivery_date
    )
    @order.update(order_params)
    redirect_to @order, notice: 'Pedido atualizado com sucesso.'
  end

  def search # fazer um seach e um follow (follow para o público externo e search para o admin)
    @order_number = params['query']
    @order = Order.find_by(order_number: @order_number)
  end

  def budgets
    @carriers = Carrier.where(status: :active)
  end

  def accepted
    @order = Order.find(params[:id])
    @order.update(status: :accepted)
    redirect_to @order, notice: 'Pedido aceito com sucesso.'
  end

  def rejected
    @order = Order.find(params[:id])
    @order.update(status: :rejected)
    redirect_to @order, alert: 'Pedido rejeitado.'
  end

  def delivered
    @order = Order.find(params[:id])
    @order.update(status: :delivered)
    redirect_to @order, notice: 'Pedido entregue!'
  end

  private

  def get_order_value(volume, weight, distance, carrier_id)
    carrier = Carrier.find(carrier_id)
    carrier.price_ranges.each do |pr|
      if (volume >= pr.volume_start && volume <= pr.volume_end) && (weight >= pr.weight_start && weight <= pr.weight_end)
        return distance * DistancePrice.find_by(carrier_id: carrier.id, price_range_id: pr.id).km_price.to_f
      end
    end
  end

  def get_delivery_date(distance, carrier_id)
    carrier = Carrier.find(carrier_id)
    carrier.delivery_distances.each do |dd|
      if distance >= dd.from_km && distance <= dd.to_km
        return DeliveryTime.find_by(carrier_id: carrier.id, delivery_distance_id: dd.id).time.days.from_now
      end
    end
  end
end
