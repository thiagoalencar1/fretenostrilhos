class AddMinimumPriceToCarrier < ActiveRecord::Migration[7.0]
  def change
    add_column :carriers, :minimum_price, :decimal, default: 5.0, null: false
  end
end
