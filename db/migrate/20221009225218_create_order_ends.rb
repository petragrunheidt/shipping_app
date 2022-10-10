class CreateOrderEnds < ActiveRecord::Migration[7.0]
  def change
    create_table :order_ends do |t|
      t.references :order, null: false, foreign_key: true
      t.date :time
      t.string :reason

      t.timestamps
    end
  end
end
