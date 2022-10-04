class AddTransportModeAttributeToWeightTable < ActiveRecord::Migration[7.0]
  def change
    add_reference :weight_tables, :transport_mode, null: false, foreign_key: true
  end
end
