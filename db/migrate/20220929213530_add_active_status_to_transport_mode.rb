class AddActiveStatusToTransportMode < ActiveRecord::Migration[7.0]
  def change
    add_column :transport_modes, :active, :boolean, default: false
  end
end
