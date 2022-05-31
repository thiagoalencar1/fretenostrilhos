class User::CarriersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_carrier, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    carrier_params
    if @carrier.update(carrier_params)
      redirect_to user_distance_prices_path, notice: 'Preço mínimo definido com sucesso.'
    else
      flash.now[:alert] = 'Preço mínimo não atualizado. Verifique o preenchimento do cadastro.'
      render :edit
    end
  end

  private

  def carrier_params
    params.require(:carrier).permit(:brand_name, :corporate_name, :email_domain, :taxpayer_number, :minimum_price)
  end

  def set_carrier
    @carrier = Carrier.find(current_user.carrier_id)
  end
end
