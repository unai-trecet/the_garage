class Garage < ActiveRecord::Base
  has_many :vehicles
  has_many :levels
  has_many :lots

  validates_presence_of :number_levels, :number_lots

  def number_of_parking_places
    self.number_levels * self.number_lots
  end

  def create_new_level?
    self.vehicles.count / ( self.number_lots * self.levels.count ) >= 1 and self.levels.count < self.number_levels ? true : false
  end

  def delete_level?
    self.vehicles.count % self.number_lots == 0 ? true : false 
  end  

  def has_empty_lot?
    ( self.number_lots * self.number_levels ) - self.vehicles.count > 0 ? true : false  
  end

  def number_of_empty_lots
    ( self.number_lots * self.number_levels ) - self.vehicles.count
  end
end