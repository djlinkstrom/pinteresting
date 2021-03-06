module Api
  module V1
    class EventsController < ApplicationController
       respond_to :json
      
      def index
        respond_with Event.all
      end
      
      def show
        respond_with Event.find(params[:id])
      end

      def nearby
        time = Time.now
        @nearby_events = []
	      @locations= view_context.getNearbyLocations()
	      @locations.each do |location|
	      @events = Event.where(:location_id => location.id).where("eventstart > ?", time)
	      @events.each do |event|
	      	@tag =  view_context.image_tag(event.image.url(:thumb))
          puts "$$$$$$$$$"
          puts "New Event"
	      	@img_url = @tag.slice(@tag.index("src")+5, @tag.index("/>") - @tag.index("src") - 7)
	        @nearby_events_hash = { location: location, event: event, image_url: @img_url}
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
      puts"$$$$$$$$$$"
      puts @nearby_events.length
      respond_with @nearby_events


      end
      
      def create
        respond_with Event.create(params[:product])
      end
      
      def update
        respond_with Event.update(params[:id], params[:products])
      end
      
      def destroy
        respond_with Event.destroy(params[:id])
      end
    
    end
  end
end