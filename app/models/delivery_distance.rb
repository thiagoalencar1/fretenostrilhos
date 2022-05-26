class DeliveryDistance < ApplicationRecord
  has_many :delivery_times

  def show_delivery_distance
    "Entre #{from_km} km — #{to_km} km"
  end
end
