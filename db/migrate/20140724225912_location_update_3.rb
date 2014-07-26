class LocationUpdate3< ActiveRecord::Migration
  def change
  	remove_column :locations, :llogitude
    add_column :locations, :longitude, :float
    add_column :locations, :address, :string

  end
end

