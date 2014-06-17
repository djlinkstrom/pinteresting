class Location < ActiveRecord::Base
	belongs_to :user
	has_many :events
	has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "120x120#" }, :default_url => "/images/best-time-default.png"
	
end
