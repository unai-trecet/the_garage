class CreateLevels < ActiveRecord::Migration
  def change
    create_table :levels do |t|
      t.references :garage, index: true
      t.timestamps
    end
    add_foreign_key :levels, :garages
  end
end
