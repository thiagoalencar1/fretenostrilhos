class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_number
      t.decimal :order_value
      t.integer :distance
      t.date :delivery_date
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :carrier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
