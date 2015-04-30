class Level < ActiveRecord::Base
  belongs_to :garage
  has_many :lots
  has_many :vehicles
end