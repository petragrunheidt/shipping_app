class CreateWeightTables < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_tables do |t|
      t.integer :min
      t.integer :max
      t.decimal :value, precision: 2

      t.timestamps
    end
  end
end
