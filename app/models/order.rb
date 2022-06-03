class Order < ApplicationRecord
  belongs_to :carrier
  has_many :tracking_logs
  before_validation :generate_order_number, on: :create

  enum status: { pending: 0, accepted: 3, delivered: 6, rejected: 9 }
  
  validate :check_date
  validates :package_weight, :package_volume, :distance, :origin_address, :destiny_address, :order_value,
            :delivery_date, presence: true
  validates :package_weight, :package_volume, :distance, numericality: true
  validate :check_volume
  validate :check_weight

  private

  def generate_order_number
    self.order_number = SecureRandom.alphanumeric(15).upcase
  end

  def self.get_order_value(volume, weight, distance, carrier_id)
    carrier = Carrier.find(carrier_id)
    carrier.price_ranges.each do |pr|
      unless (volume >= pr.volume_start && volume <= pr.volume_end) && (weight >= pr.weight_start && weight <= pr.weight_end)
        next
      end

      total_order_value = distance * DistancePrice.find_by(carrier_id: carrier.id, price_range_id: pr.id).km_price.to_f
      total_order_value = carrier.minimum_price if total_order_value < carrier.minimum_price
      
      return total_order_value
    end
  end

  def self.get_delivery_date(distance, carrier_id)
    carrier = Carrier.find(carrier_id)
    carrier.delivery_distances.each do |dd|
      if distance >= dd.from_km && distance <= dd.to_km
        return DeliveryTime.find_by(carrier_id: carrier.id, delivery_distance_id: dd.id).time.days.from_now
      end
    end
  end

  def check_volume
    carrier = Carrier.find(carrier_id)
    max_volume = carrier.price_ranges.maximum(:volume_end).to_f
    if package_volume.to_f < 0.01
      errors.add(:package_volume, 'deve ser maior ou igual a 0,01m³')
    elsif package_volume.to_f > max_volume
      errors.add(:package_volume, 'máximo para esta transportadora é de: ' + max_volume.to_s + 'm³')
    end
  end

  def check_weight
    carrier = Carrier.find(carrier_id)
    max_weight = carrier.price_ranges.maximum(:weight_end).to_f
    if package_weight.to_f < 0.01
      errors.add(:package_weight, 'deve ser maior ou igual a 0,01kg')
    elsif package_weight.to_f > max_weight
      errors.add(:package_weight, 'máximo para esta transportadora é de: ' + max_weight.to_s + 'kg')
    end
  end

  def check_date
    carrier = Carrier.find(carrier_id)
    min_distance = carrier.delivery_distances.minimum(:from_km).to_i
    max_distance = carrier.delivery_distances.maximum(:to_km).to_i

    if (min_distance..max_distance).include?(distance.to_i)
    else
      errors.add(:delivery_date, 'não disponível para esta transportadora nas especificações solicitadas.')
    end
  end
end
