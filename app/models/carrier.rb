class Carrier < ApplicationRecord
  has_many :users
  has_many :distance_prices
  has_many :price_ranges, through: :distance_prices
  has_many :delivery_times
  has_many :delivery_distances, through: :delivery_times

  enum status: { active: 0, inactive: 5 }

  validates :brand_name, :corporate_name, :email_domain, :taxpayer_number, presence: true
  validates :taxpayer_number, length: { is: 14, message: 'deve ter 14 digitos.' }
  validates :taxpayer_number, numericality: true
  validates :taxpayer_number, :email_domain, uniqueness: true

  def total_order_value(volume, weight, distance)
    price_ranges.each do |pr|
      if (volume >= pr.volume_start && volume <= pr.volume_end) && (weight >= pr.weight_start && weight <= pr.weight_end)
        return distance * DistancePrice.find_by(carrier_id: id, price_range_id: pr.id).km_price
      end
    end
  end

  def estimated_delivery_date(distance)
    delivery_distances.each do |dd|
      if distance >= dd.from_km && distance <= dd.to_km
        return DeliveryTime.find_by(carrier_id: id, delivery_distance_id: dd.id).time
      end
    end
  end
end
