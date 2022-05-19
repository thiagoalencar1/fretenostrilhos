class CarriersController < ApplicationController
  before_action :authenticate_user!

  def index
    @carriers = Carrier.all
  end

  def show
    @carrier = Carrier.find(params[:id])
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
      redirect_to @carrier, notice: 'Transportadora salva com sucesso.'
    else
      flash[:alert] = 'Verifique o preenchimento do cadastro.'
      render :new
    end
  end

  def edit
    @carrier = Carrier.find(params[:id])
  end

  def update
    @carrier = Carrier.find(params[:id])

    if @carrier.update(params.require(:carrier).permit(:brand_name, :corporate_name,
                                                       :email_domain, :taxpayer_number, :status))

      flash[:notice] = 'Transportadora atualizada com sucesso.'
      redirect_to carrier_path
    else
      flash[:alert] = 'Atualização não realizada. Verifique o preenchimento do cadastro.'
      render :edit
    end
  end
end
