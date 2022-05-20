class RemoveCarrierIdFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :carrier_id, :integer
  end
end
