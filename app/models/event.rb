class Event < ActiveRecord::Base
	belongs_to :location
	has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "120x120#" }, :default_url => "/images/best-time-default.png"

	def eventstart_date_field  # What this returns will be what is shown in the field
	  full_date.strftime("%m-%d'%y") if full_date.present?
	end 

	def eventstart_time_field
	  full_date.strftime("%I:%M%p") if full_date.present?
	end

	def time_field=(time)
	  eventstart = DateTime.parse("#{eventstart_date_field} #{eventstart_time_field}")
	end

end
