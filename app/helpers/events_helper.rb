module EventsHelper


	def getNearbyLocations()
		 if !params[:location].blank?
		 	@location ||= Geocoder.search(params[:location]).first
		 elsif !params[:latitude].blank? && !params[:longitude].blank?
			@location ||= Geocoder.search(params[:latitude] + ", " + params[:longitude]).first
		else
		 	@ip_address = request.remote_ip
			if Rails.env.test? || Rails.env.development?
		      @location ||= Geocoder.search("71.234.166.197").first
		    else
		      @location ||= request.location
		    end
		end
	    @locations = Location.select("id, placename, address, timezone").near([@location.latitude, @location.longitude], 20)
    end
end
