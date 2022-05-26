class DistancePrice < ApplicationRecord
  belongs_to :carrier
  belongs_to :price_range

  validates :price_range_id,
            uniqueness: { scope: :carrier_id,
                          message: 'Preço por km já cadastrado para esta Transportadora. Tente editar o cadastro.' }
end
