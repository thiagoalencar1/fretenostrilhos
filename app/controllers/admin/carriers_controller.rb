class Admin::CarriersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_carrier, only: %i[show edit update]

  def index
    @carriers = Carrier.all
  end

  def show; end

  def new
    @carrier = Carrier.new
  end

  def create
    @carrier = Carrier.new(carrier_params)
    @carrier.save

    if @carrier.save
      redirect_to [:admin, @carrier], notice: 'Transportadora salva com sucesso.'
    else
      flash[:alert] = 'Verifique o preenchimento do cadastro.'
      render :new
    end
  end

  def edit; end

  def update
    carrier_params

    if @carrier.update(carrier_params)
      flash[:notice] = 'Transportadora atualizada com sucesso.'
      redirect_to admin_carrier_path
    else
      flash[:alert] = 'Atualização não realizada. Verifique o preenchimento do cadastro.'
      render :edit
    end
  end

  private

  def set_carrier
    @carrier = Carrier.find(params[:id])
  end

  def carrier_params
    params.require(:carrier).permit(
      :brand_name, :corporate_name, :email_domain, :taxpayer_number, :status
    )
  end
end
