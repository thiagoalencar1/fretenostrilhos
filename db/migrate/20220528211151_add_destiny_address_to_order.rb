class AddDestinyAddressToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :destiny_address, :string
  end
end
