class DistancePrice < ApplicationRecord
  belongs_to :carrier
  belongs_to :price_range
end
