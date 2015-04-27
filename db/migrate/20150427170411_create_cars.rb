class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.references :vehicles, index:true
      t.timestamps
    end
  end
end
