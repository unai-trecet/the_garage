class CreateMotorbikes < ActiveRecord::Migration
  def change
    create_table :motorbikes do |t|
      t.references :vehicles, index: true
      t.timestamps
    end
    
    add_foreign_key :motorbikes, :vehicles
  end
end
