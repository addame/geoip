class Location < ActiveRecord::Base
  attr_accessible :ip_address, :address, :name, :description
  validates :address, :presence => true
  acts_as_gmappable
  def gmaps4rails_address
    "#{self.address}" 
  end
  geocoded_by :ip_address  
  after_validation :geocode
end
