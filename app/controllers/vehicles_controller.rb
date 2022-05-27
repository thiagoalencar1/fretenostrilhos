class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :this_carrier

  def index
    @vehicles = Vehicle.where(carrier_id: current_user.carrier_id)
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.save

    if @vehicle.save
      redirect_to vehicles_path, notice: 'Veículo salvo com sucesso.'
    else
      flash[:alert] = 'Verifique o preenchimento dos campos.'
      render :new
    end
  end

  def edit
    @vehicle = Vehicle.find(params[:id])
  end

  def update
    @vehicle = Vehicle.find(params[:id])
    vehicle_params

    if @vehicle.update(vehicle_params)
      flash[:notice] = 'Veículo atualizado com sucesso.'
      redirect_to vehicles_path
    else
      flash[:alert] = 'Atualização falhou. Verifique o preenchimento dos campos.'
      render :edit
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:model, :brand, :year, :license_plate, :carrier_id)
  end

  def this_carrier
    @carrier = Carrier.find(current_user.carrier_id)
  end
end
