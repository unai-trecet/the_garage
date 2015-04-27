class Vehicles < ActiveRecord::Migration
  def change
    t.integer :plate, index: true
    t.timestamp
  end
end
