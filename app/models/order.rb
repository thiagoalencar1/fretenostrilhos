class Order < ApplicationRecord
  belongs_to :carrier
  before_create :generate_order_number
  # before_create -> { get_order_value(@volume, @weight, @distance, id) }
  # before_create -> { get_delivery_date(@distance, @self.id) }

  enum status: { pending: 0, accepted: 3, delivered: 6, rejected: 9 }

  validates :package_weight, :package_volume, :distance, :origin_address, :destiny_address, :order_value,
            :delivery_date, presence: true
  validates :package_weight, :package_volume, :distance, numericality: true

  private

  def generate_order_number
    self.order_number = SecureRandom.alphanumeric(15).upcase
  end

  def get_order_value(volume, weight, distance, carrier_id)
    carrier = Carrier.find(carrier_id)
    carrier.price_ranges.each do |pr|
      if (volume >= pr.volume_start && volume <= pr.volume_end) && (weight >= pr.weight_start && weight <= pr.weight_end)
        return distance * DistancePrice.find_by(carrier_id: carrier.id, price_range_id: pr.id).km_price
      end
    end
  end

  def get_delivery_date(distance, carrier_id)
    carrier = Carrier.find(carrier_id)
    carrier.delivery_distances.each do |dd|
      if distance >= dd.from_km && distance <= dd.to_km
        return DeliveryTime.find_by(carrier_id: carrier.id, delivery_distance_id: dd.id).time.days.from_now
      end
    end
  end
end
