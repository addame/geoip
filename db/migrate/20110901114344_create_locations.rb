class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.float :users, :latitude
      t.float :users, :longitude
      t.string :description
      t.boolean :users, :gmaps
      t.timestamps
    end
  end
end
