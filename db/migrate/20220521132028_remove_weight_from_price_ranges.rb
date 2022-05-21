class RemoveWeightFromPriceRanges < ActiveRecord::Migration[7.0]
  def change
    remove_column :price_ranges, :weight, :decimal
  end
end
