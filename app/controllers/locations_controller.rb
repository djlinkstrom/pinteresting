class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: []

  # GET /locations
  # GET /locations.json
  def index
    #@locations = Location.all
    #@players = Player.where(current_user.= ?, 'player.team_id')
    #@items = Item.find_all_by_user_id current_user[:id]
    @locations = Location.find_all_by_user_id current_user[:id]

  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    time = Time.now
    @events = Event.where(:location_id => @location[:id]).where("eventend > ?", time).order('eventstart ASC, created_at ASC')
    @hash = Gmaps4rails.build_markers(@location) do |location, marker|
      if(location.lat)
        marker.lat location.lat
        marker.lng location.lng
      else
        marker.lat "41.7678"
        marker.lng "-72.7539"
      end
    end
    #@events = Event.find_all_by_location_id @location[:id]
  end

  # GET /locations/new
  def new
    #@location = Location.new
    @location = current_user.locations.build 
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    #@location = Location.new(location_params)
    @location = current_user.locations.build(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render action: 'show', status: :created, location: @location }
      else
        format.html { render action: 'new' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    puts location_params[:timezone]
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:category, :placename, :address_1, :town, :postcode, :state, :lng, :lat, :image, :timezone)
    end

    def correct_user
      @location = current_user.locations.find_by(id: params[:id])
      redirect_to locations_path, notice: "Not authorized to view this location" if @location.nil?
    end
end
