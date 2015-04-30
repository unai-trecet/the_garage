class RanameColumns < ActiveRecord::Migration
  def change
    change_table :garages do |t|
      t.rename :levels, :number_levels
      t.rename :lots, :number_lots
    end    
  end
end
