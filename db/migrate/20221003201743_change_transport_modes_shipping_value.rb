class ChangeTransportModesShippingValue < ActiveRecord::Migration[7.0]
  def change
    rename_column :transport_modes, :shipping_value, :fixed_rate
  end
end
