class ChangeWeightTableDecimalPrecision < ActiveRecord::Migration[7.0]
  def change
    change_column :weight_tables, :value, :decimal, scale: 2
  end
end
