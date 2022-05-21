class DistancePricesController < ApplicationController
  def index
    @price_ranges = PriceRange.all
    @distance_prices = DistancePrice.where(carrier_id: current_user.carrier_id)
  end

  def new
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
end
