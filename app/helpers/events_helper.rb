module EventsHelper

	def getNearbyLocations()
		 if params[:location].blank?
		 	@ip_address = request.remote_ip
			if Rails.env.test? || Rails.env.development?
		      @location ||= Geocoder.search("71.234.166.197").first
		    else
		      @location ||= request.location
		    end
		else
			@location ||= Geocoder.search(params[:location]).first
		end
	    @locations = Location.near([@location.latitude, @location.longitude], 20)
    end
end
