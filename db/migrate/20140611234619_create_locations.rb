class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :category
      t.string :placename
      t.string :address_1
      t.string :address_2
      t.string :town
      t.string :postcode

      t.timestamps
    end
  end
end
