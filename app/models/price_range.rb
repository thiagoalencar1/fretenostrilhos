class PriceRange < ApplicationRecord
  has_many :distance_prices

  def show_price_range
    "#{volume_start}m³ - #{volume_end}m³ / #{weight_start}kg - #{weight_end}kg"
  end
end
