class AddsColumnsToOrderStart < ActiveRecord::Migration[7.0]
  def change
    add_column :order_starts, :order_date, :date
    add_column :order_starts, :shipping_fee, :integer
    add_column :order_starts, :delivery_deadline, :date
  end
end
