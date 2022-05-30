class PriceRange < ApplicationRecord
  has_many :distance_prices

  validates :volume_start, :volume_end, :weight_start, :weight_end, presence: true

  def show_price_range
    "#{volume_start}m³ - #{volume_end}m³ / #{weight_start}kg - #{weight_end}kg"
  end
end
