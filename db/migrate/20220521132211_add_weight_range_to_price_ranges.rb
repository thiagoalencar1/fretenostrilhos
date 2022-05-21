class AddWeightRangeToPriceRanges < ActiveRecord::Migration[7.0]
  def change
    add_column :price_ranges, :weight_start, :decimal, precision: 12, scale: 2
    add_column :price_ranges, :weight_end, :decimal, precision: 12, scale: 2
  end
end
