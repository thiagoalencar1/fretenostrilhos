class CarriersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @carriers = Carrier.all
  end
end
