class Event < ActiveRecord::Base
	belongs_to :location
	has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "120x120#" }, :default_url => "/images/best-time-default.png"

	def image_url
        image.url(:thumb)
    end
end
