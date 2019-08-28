class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.text :input_address
      t.text :formatted_address
      t.text :address_fetch_error
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      
      t.timestamps
    end
  end
end
