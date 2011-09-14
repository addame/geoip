class HomeController < ApplicationController
  def index
    @locations = Location.all
    @json = @locations.to_gmaps4rails
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @locations }
      end
  end
end
