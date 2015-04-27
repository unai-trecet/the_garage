class CreateGarage < ActiveRecord::Migration
  def change
    create_table :garages do |t|
      t.integer :levels, :lots
      t.timestamps
    end
  end
end
