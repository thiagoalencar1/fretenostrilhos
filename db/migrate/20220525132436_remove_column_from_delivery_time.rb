class RemoveColumnFromDeliveryTime < ActiveRecord::Migration[7.0]
  def change
    remove_reference :delivery_times, :delivery_distances, null: false, foreign_key: true
  end
end
