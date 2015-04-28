class Garage < ActiveRecord::Base
  validates_presence_of :levels, :lots
end