class LocationUpdate < ActiveRecord::Migration
  def change

    remove_column :locations, :address_2
    add_column :locations, :state, :string
    add_column :locations, :lat, :string
    add_column :locations, :lng, :string

  end
end
