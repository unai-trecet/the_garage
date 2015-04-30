class AddLotReferenceToVehicle < ActiveRecord::Migration
  def change
    add_foreign_key :vehicles, :lot
    add_reference :vehicles, :lot
  end
end
