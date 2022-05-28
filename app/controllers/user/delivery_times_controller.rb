class User::DeliveryTimesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrier

  def index
    @delivery_distances = DeliveryDistance.all
    @delivery_times = DeliveryTime.where(carrier_id: current_user.carrier_id)
  end

  def new
    @delivery_distance = DeliveryDistance.find(params[:delivery_distance_id])
    @delivery_time = DeliveryTime.new
  end

  def create
    @delivery_time = DeliveryTime.new(delivery_time_params)
    @delivery_time.save

    if @delivery_time.save
      redirect_to user_delivery_times_path, notice: 'Estimativa de entrega cadastrada com sucesso.'
    else
      flash[:alert] = 'Estivativa não cadastrada. Verifique o preenchimento do cadastro.'
      render :new
    end
  end

  def edit
    @delivery_time = DeliveryTime.find(params[:id])
    @delivery_distance = DeliveryDistance.find(@delivery_time.delivery_distance_id)
  end

  def update
    @delivery_time = DeliveryTime.find(params[:id])
    @delivery_distance = DeliveryDistance.find(@delivery_time.delivery_distance_id)

    delivery_time_params

    if @delivery_time.update(delivery_time_params)
      flash[:notice] = 'Estimativa de entrega atualizada com sucesso.'
      redirect_to user_delivery_times_path
    else
      flash[:alert] = 'Atualização falhou. Verifique o preenchimento do cadastro.'
    end
  end

  private

  def set_carrier
    @carrier = Carrier.find(current_user.carrier_id)
  end

  def delivery_time_params
    params.require(:delivery_time).permit(:time, :carrier_id, :delivery_distance_id)
  end
end
