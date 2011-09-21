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
    "#{self.description}" 
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
  after_validation :geocode
  geocoded_by :address
  def get_near(radius, lat, lng)
    radius = 50 unless radius
    return Location.near(Geocoder.search("#{lat}, #{lng}")[0].data["formatted_address"], (radius*2)/3, :order => :distance)
  end
end
