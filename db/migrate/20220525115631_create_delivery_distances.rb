class CreateDeliveryDistances < ActiveRecord::Migration[7.0]
  def change
    create_table :delivery_distances do |t|
      t.integer :from_km
      t.integer :to_km

      t.timestamps
    end
  end
end
