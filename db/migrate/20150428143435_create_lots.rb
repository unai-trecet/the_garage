class CreateLots < ActiveRecord::Migration
  def change
    create_table :lots do |t|
      t.references :garage, index: true
      t.references :level, index: true
      t.references :vehicle, index: true

      t.timestamps
    end
    add_foreign_key :lots, :garages
    add_foreign_key :lots, :levels
    add_foreign_key :lots, :vehicles
  end
end
