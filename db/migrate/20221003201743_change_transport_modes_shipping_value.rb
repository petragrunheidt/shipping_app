class ChangeTransportModesShippingValue < ActiveRecord::Migration[7.0]
  def change
    rename_column :transport_modes, :fixed_rate, :fixed_rate
  end
end
