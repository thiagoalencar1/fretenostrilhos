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
