class CarriersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @carriers = Carrier.all
  end

  def new
    @carrier = Carrier.new
  end

  def create
    @carrier = Carrier.new(
      params.require(:carrier).permit(:brand_name, :corporate_name,
                                      :email_domain, :taxpayer_number, :status)
    )

    @carrier.save

    if @carrier.save
      redirect_to carriers_path, notice: 'Transportadora salva com sucesso.'
    else
      flash[:alert] = 'Verifique o preenchimento do cadastro.'
      render :new
    end
  end
end
