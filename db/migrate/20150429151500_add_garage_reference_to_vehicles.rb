class AddGarageReferenceToVehicles < ActiveRecord::Migration
  def change
    add_foreign_key :vehicles, :garage
    add_reference :vehicles, :garage   
  end
end
