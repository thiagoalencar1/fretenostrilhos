class Admin::PriceRangesController < ApplicationController
  before_action :set_price_range, only: [:edit, :update]

  def index
    @price_ranges = PriceRange.all
  end

  def new
    @price_range = PriceRange.new
  end

  def create
    price_range_params = params.require(:price_range).permit(:volume_start, :volume_end, :weight_start, :weight_end)
    @price_range = PriceRange.new(price_range_params)
  
    if @price_range.save
      redirect_to admin_price_ranges_path, notice: 'Intervalo de Medidas cadastrado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    price_range_params = params.require(:price_range).permit(:volume_start, :volume_end, :weight_start, :weight_end)
    @price_range.update(price_range_params)
    if @price_range.save
      redirect_to admin_price_ranges_path, notice: 'Intervalo de Medidas atualizado com sucesso.'
    else
      flash.now[:alert] = 'Verifique os valores inseridos'
      render :edit
    end

  end

  def set_price_range
    @price_range = PriceRange.find(params[:id])
  end

end
