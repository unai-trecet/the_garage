class AddLevelReferenceToVehicle < ActiveRecord::Migration
  def change
    add_foreign_key :vehicles, :level
    add_reference :vehicles, :level
  end
end
