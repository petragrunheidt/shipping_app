class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :nameplate
      t.string :vehicle_brand
      t.string :vehicle_model
      t.integer :manifacture_year
      t.integer :maximum_load
      t.references :transport_mode, null: false, foreign_key: true
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
