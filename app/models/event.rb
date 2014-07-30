class Event < ActiveRecord::Base
	belongs_to :location
	has_attached_file :image, :styles => { :medium => "300x300", :small => "100x100", :thumb => "50x50" }, :default_url => "/images/best-time-default.png"

	def image_url
        self.image.url(:thumb)
    end
end
