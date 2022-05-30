class CreateTrackingLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :tracking_logs do |t|
      t.string :what
      t.string :where
      t.datetime :when
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
