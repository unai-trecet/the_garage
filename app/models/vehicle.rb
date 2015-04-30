class Vehicle < ActiveRecord::Base
  belongs_to :lot
  belongs_to :level
  belongs_to :garage

  validates_presence_of :plate
  validates_uniqueness_of :plate
end