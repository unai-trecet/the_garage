class Lot < ActiveRecord::Base
  belongs_to :garage
  belongs_to :level
  belongs_to :vehicle
end