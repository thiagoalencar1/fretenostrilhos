class AddColumnsToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :package_volume, :decimal
    add_column :orders, :package_weight, :decimal
    add_column :orders, :origin_address, :string
    add_column :orders, :status, :integer, default: 0
  end
end
