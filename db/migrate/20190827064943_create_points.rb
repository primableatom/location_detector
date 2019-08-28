class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.decimal :latitude, precision: 9, scale: 6
      t.decimal :longitude, precision: 9, scale: 6
      t.references :feature, index: true

      t.timestamps
    end
  end
end
