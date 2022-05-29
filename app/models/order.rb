class Order < ApplicationRecord
  belongs_to :carrier
  before_create :generate_order_number

  enum status: { pending: 0, accepted: 3, delivered: 6, canceled: 9 }

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
end
