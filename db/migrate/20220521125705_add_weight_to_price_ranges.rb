class AddWeightToPriceRanges < ActiveRecord::Migration[7.0]
  def change
    add_column :price_ranges, :weight, :decimal, precision: 12, scale: 2
  end
end
