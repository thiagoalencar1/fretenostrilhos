class CreatePriceRanges < ActiveRecord::Migration[7.0]
  def change
    create_table :price_ranges do |t|
      t.decimal :volume_start, precision: 12, scale: 2
      t.decimal :volume_end, precision: 12, scale: 2

      t.timestamps
    end
  end
end
