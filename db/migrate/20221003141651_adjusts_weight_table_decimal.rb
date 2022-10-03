class AdjustsWeightTableDecimal < ActiveRecord::Migration[7.0]
  def change
    change_column :weight_tables, :value, :decimal, precision: 10, scale: 2
  end
end
