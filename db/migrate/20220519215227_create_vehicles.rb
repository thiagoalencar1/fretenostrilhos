class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :brand
      t.string :license_plate
      t.integer :year
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
