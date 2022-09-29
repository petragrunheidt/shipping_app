class ChangeActiveToStatusAndEnum < ActiveRecord::Migration[7.0]
  def change
    rename_column :transport_modes, :active, :status
    change_column :transport_modes, :status, :integer, default: 0
  end
end
