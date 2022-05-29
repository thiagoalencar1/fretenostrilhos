class DeliveryTime < ApplicationRecord
  belongs_to :carrier
  belongs_to :delivery_distance

  validates :time, :carrier_id, :delivery_distance_id, presence: true
  validates :time,
            numericality: { in: 1..99, message: 'não pode ser menor que 1 ou maior que 99 ' }

  validates :delivery_distance_id,
            uniqueness: { scope: :carrier_id, message: 'já cadastrado para esta Transportadora.' }
end
