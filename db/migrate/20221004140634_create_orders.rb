class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :takeout_address
      t.string :code
      t.integer :weight
      t.integer :heigth
      t.integer :width
      t.integer :depth
      t.string :delivery_address
      t.string :name
      t.string :email
      t.string :customer_id

      t.timestamps
    end
  end
end
