class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_filter :load_location
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  def nearby
    @nearby_events = []
    @locations= view_context.getNearbyLocations()
    @locations.each do |location|
      @events = Event.where(:location_id => location.id)
      @events.each do |event|
        @nearby_events_hash = { location: location, event: event}
        if @nearby_events.empty?
          @nearby_events.push(@nearby_events_hash)
        else
          @place = 0
          @nearby_events.each do |nearby_event|  
            break if nearby_event[:event].eventstart.in_time_zone('Eastern Time (US & Canada)') > event.eventstart.in_time_zone('Eastern Time (US & Canada)')
            @place = @place + 1
          end          
          @nearby_events.insert(@place, @nearby_events_hash)          
        end
      end
    end
    #@events = Event.all
    #@events = Event.where("location.lat = 41.7678")
  end

  # GET /events/new
  def new
    @event = @location.events.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create 
    timezone = ActiveSupport::TimeZone.new(@location.timezone)
    custom_event_params = event_params
    custom_event_params[:eventstart] = DateTime.strptime(custom_event_params[:eventstart], '%m/%d/%Y %I:%M %p').change(:offset => timezone.now.formatted_offset)
    custom_event_params[:eventend] = DateTime.strptime(custom_event_params[:eventend], '%m/%d/%Y %I:%M %p').change(:offset => timezone.now.formatted_offset)
    @event = @location.events.new(custom_event_params)  
    if @event[:image_file_name].blank?
      @event.update_attribute(:image, @location.image)
    end
    respond_to do |format|
      if @event.save
        format.html { redirect_to [@location, @event], notice: 'Event was successfully created.' }
        format.json { render action: 'show', status: :created, location: @event }
      else
        format.html { render action: 'new' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to [@location, @event], notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    def load_location
      if params[:location_id].blank?
      else
        @location = Location.find(params[:location_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:eventname, :eventdesc, :eventstart, :eventend, :image)
    end
end
