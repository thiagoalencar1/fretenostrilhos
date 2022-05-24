class DistancePricesController < ApplicationController
  before_action :this_carrier

  def index
    @price_ranges = PriceRange.all
    @distance_prices = DistancePrice.where(carrier_id: current_user.carrier_id)
  end

  def new
    @price_range = PriceRange.find(params[:price_range_id])
    @distance_price = DistancePrice.new
  end

  def create
    @distance_price = DistancePrice.new(params.require(:distance_price).permit(:km_price, :carrier_id, :price_range_id))
    @distance_price.save

    if @distance_price.save
      redirect_to distance_prices_path, notice: 'Preço por Km cadastrado com sucesso.'
    else
      flash[:alert] = 'Verifique o preenchimento do cadastro.'
      render :new
    end
  end

  def edit
    @distance_price = DistancePrice.find(params[:id])
    @price_range = PriceRange.find(@distance_price.price_range_id)
  end

  def update
    @distance_price = DistancePrice.find(params[:id])
    @price_range = PriceRange.find(@distance_price.price_range_id)

    if @distance_price.update(params.require(:distance_price).permit(:km_price, :carrier_id, :price_range_id))
      redirect_to distance_prices_path, notice: 'Preço por Km atualizado com sucesso.'
    else
      flash[:alert] = 'Verifique o preenchimento do cadastro.'
      render :new
    end
  end

  private

  def this_carrier
    @carrier = Carrier.find(current_user.carrier_id)
  end
end
