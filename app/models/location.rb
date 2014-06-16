class Location < ActiveRecord::Base
	belongs_to :user
	has_many :events
	has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "80x80>" }, :default_url => "/images/best_time_logo_very_small.png"
	
end
