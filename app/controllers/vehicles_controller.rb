class VehiclesController < ApplicationController
  before_action :authenticate_user!

  def index
    @vehicles = Vehicle.all
  end

  def new
    @vehicle = Vehicle.new
  end

  def create
    @vehicle = Vehicle.new(vehicle_params)
    @vehicle.save

    if @vehicle.save
      redirect_to vehicles_path, notice: 'Transportadora salva com sucesso.'
    else
      flash[:alert] = 'Verifique o preenchimento do cadastro.'
      render :new
    end
  end

  private

  def vehicle_params
    params.require(:vehicle).permit(:model, :brand, :year, :license_plate, :carrier_id)
  end
end
