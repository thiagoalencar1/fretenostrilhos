class AddCarrierIdToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :carrier, null: false, foreign_key: true
  end
end
