class AddColumnsNumberToLevelsAndLots < ActiveRecord::Migration
  def change
    add_column :levels, :number, :integer
    add_column :lots, :number, :integer
  end
end
