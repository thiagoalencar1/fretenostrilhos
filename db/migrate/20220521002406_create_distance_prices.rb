class CreateDistancePrices < ActiveRecord::Migration[7.0]
  def change
    create_table :distance_prices do |t|
      t.decimal :km_price, precision: 12, scale: 2
      t.references :carrier, null: false, foreign_key: true
      t.references :price_range, null: false, foreign_key: true

      t.timestamps
    end
  end
end
