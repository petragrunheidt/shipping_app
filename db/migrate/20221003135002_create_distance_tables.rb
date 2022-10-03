class CreateDistanceTables < ActiveRecord::Migration[7.0]
  def change
    create_table :distance_tables do |t|
      t.integer :min
      t.integer :max
      t.decimal :value, precision: 10, scale: 2

      t.timestamps
    end
  end
end
