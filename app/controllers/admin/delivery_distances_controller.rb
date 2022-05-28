class Admin::DeliveryDistancesController < ApplicationController
  def index
    @delivery_distances = DeliveryDistance.all
  end
end
