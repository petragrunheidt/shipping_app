class AddTransportModeAttributeToDistanceTable < ActiveRecord::Migration[7.0]
  def change
    add_reference :distance_tables, :transport_mode, null: false, foreign_key: true
  end
end
