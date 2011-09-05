class LocationsController < ApplicationController
  respond_to :json, :html
  def show_me
    @remote_ip = request.env["HTTP_X_FORWARDED_FOR"]
    @location = Location.create(:ip_address => "#{request.remote_ip}", :adress => '')
    #@location = Location.create(:ip_address => "212.69.208.218")
    @json = @location.to_gmaps4rails
    respond_to do |format|
      format.html # show_me.html.erb
      format.json { render json: @location }
    end
  end
  def relace_markers 
    @locations = Location.all
    @json = @locations.to_gmaps4rails
    respond_with(@json)
  end
  # GET /locations
  # GET /locations.json
  def index
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

    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :ok }
    end
  end
end
