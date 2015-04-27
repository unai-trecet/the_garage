class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :plate, index: true
      t.timestamp      
    end
  end
end
