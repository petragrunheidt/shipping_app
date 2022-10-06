class CreateDeadlines < ActiveRecord::Migration[7.0]
  def change
    create_table :deadlines do |t|
      t.integer :min
      t.integer :max
      t.integer :time
      t.references :transport_mode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
