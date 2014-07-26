class LocationUpdate2 < ActiveRecord::Migration
  def change
  	remove_column :locations, :address_1
    remove_column :locations, :town
    remove_column :locations, :state
    remove_column :locations, :lat
    remove_column :locations, :lng
	remove_column :locations, :postcode
    add_column :locations, :latitude, :float
    add_column :locations, :longitude, :float
    add_column :locations, :address, :string

  end
end

