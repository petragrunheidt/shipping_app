class CreateOrderStarts < ActiveRecord::Migration[7.0]
  def change
    create_table :order_starts do |t|
      t.references :order, null: false, foreign_key: true
      t.references :transport_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
