class TrackingLogsController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @tracking_log = TrackingLog.new
  end

  def create
    @order = Order.find(params[:order_id])
    @tracking_log = TrackingLog.new(params.require(:tracking_log).permit(:what, :when, :where, :order_id))
    @tracking_log.order = @order
    @tracking_log.save
    if @tracking_log.save
      redirect_to @order, notice: 'Atualização de rota registrada com sucesso.'
    else
      flash.now[:alert] = 'Atualização de rota não registrada. Confira o preenchimento.'
      render :new
    end
  end
end
