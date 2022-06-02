class DeliveryDistance < ApplicationRecord
  has_many :delivery_times

  validates :to_km, :from_km, presence: true
  validates :to_km, :from_km, numericality: true
  validates :to_km, :from_km, uniqueness: true 

  #validate :unique_delivery_distance_range, if: :attributes_present?

  def show_delivery_distance
    "Entre #{from_km} km — #{to_km} km"
  end

  private

  def attributes_present?
    [:to_km, :from_km].all?(&:present?)
  end

  def unique_delivery_distance_range
    min_distance = DeliveryDistance.minimum(:from_km)
    max_distance = DeliveryDistance.maximum(:to_km)

    if (min_distance..max_distance).include?(self.from_km.to_i)
      errors.add(:from_km, 'já está contemplado em um intervalo de distância cadastado anteriormente.')
    elsif (min_distance..max_distance).include?(self.to_km.to_i)
      errors.add(:to_km, 'já está contemplado em um intervalo de distância cadastado anteriormente.')
    end
  end

end
