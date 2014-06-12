class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :eventname
      t.text :eventdesc
      t.datetime :eventstart
      t.datetime :eventend

      t.timestamps
    end
  end
end
