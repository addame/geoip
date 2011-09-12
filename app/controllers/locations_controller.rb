class LocationsController < ApplicationController
  respond_to :json, :html
  def show_me
    @remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    @location = Location.create(:ip_address => "#{request.remote_ip}", :adress => '')
    @json = @location.to_gmaps4rails
    respond_to do |format|
      format.html # show_me.html.erb
      format.json { render json: @location }
    end
  end
  def relace_markers
    @locations = Location.all
    @json = @locations.to_gmaps4rails
    respond_with @json
  end
  def index2
    radius = 50
    radius = params[:radius].to_i if params[:radius].present?
    @remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    @location_old = Location.where("name = 'my position'").first
    @location_old.destroy if @location_old.present?
    #@location = Location.new(:ip_address => "77.47.200.1", :address => "me", :name => "my position")
    @location = Location.new(:ip_address => "#{request.remote_ip}", :address => "me", :name => "my position")
    @location.save
    @location_near = Location.near(Geocoder.search("#{@location.latitude}, #{@location.longitude}")[0].data["formatted_address"], (radius*2)/3, :order => :distance)
    @json = @location_near.to_gmaps4rails
    respond_with(@json)
  end

  # GET /locations
  # GET /locations.json
  def index
    @location_old = Location.where("name = 'my position'").first
    @location_old.destroy if @location_old.present?
    @locations = Location.all
    @json = @locations.to_gmaps4rails
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @locations }
    end
  end
  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  def new
    @location = Location.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy

    respond_to do|format|
      format.html { redirect_to locations_url }
      format.json { head :ok }
    end
  end

end
