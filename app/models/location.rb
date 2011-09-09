class Location < ActiveRecord::Base
  attr_accessible :ip_address, :address, :name, :description
  validates :address, :presence => true
  acts_as_gmappable
  def gmaps4rails_address
    "#{self.address}" 
  end
  def gmaps4rails_infowindow
    "<h1>#{self.name}</h1>"
  end
  def gmaps4rails_link
    id.to_s
  end
  def gmaps4rails_sidebar
    "#{self.name}" 
  end

  def gmaps4rails_marker_picture
    if self.name.eql?('my position')
      {
        "picture" => "/images/blue-marker.png",
        "width" => "25",
        "height" => "35",
      }
    else
      {
        "picture" => "/images/marker.png",
	"width" => "25",
	"height" => "35",
      }
    end
  end  

  geocoded_by :ip_address  
  after_validation :geocode
end
