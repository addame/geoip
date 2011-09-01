class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :url
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :description

      t.timestamps
    end
  end
end
