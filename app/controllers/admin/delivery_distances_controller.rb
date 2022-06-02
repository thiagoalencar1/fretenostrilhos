class Admin::DeliveryDistancesController < ApplicationController
  before_action :set_delivery_distance, only: [:edit, :update]

  def index
    @delivery_distances = DeliveryDistance.order(:to_km)
  end

  def new
    @delivery_distance = DeliveryDistance.new
  end

  def create
    @delivery_distance = DeliveryDistance.new(params.require(:delivery_distance).permit(:from_km, :to_km))
    @delivery_distance.save

    if @delivery_distance.save
      redirect_to admin_delivery_distances_path, notice: 'Intervalo de Distância salvo com sucesso.'
    else
      flash.now[:alert] = 'Verifique os valores inseridos'
      render :new
    end
  end

  def edit;end

  def update
    @delivery_distance.update(params.require(:delivery_distance).permit(:from_km, :to_km))
    if @delivery_distance.save
      redirect_to admin_delivery_distances_path, notice: 'Intervalo de Distância atualizado com sucesso.'
    else
      flash.now[:alert] = 'Verifique os valores inseridos'
      render :edit
    end
  end

  private

  def set_delivery_distance
    @delivery_distance = DeliveryDistance.find(params[:id])
  end
end
