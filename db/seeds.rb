# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ApiKey.destroy_all

ApiKey.create!

Feature.destroy_all

path = File.join(Rails.root, 'exports', 'Given_areas.json')
file = File.open(path)
data = JSON.load(file)
data['features'].each do |feature_data|
  feature = Feature.create!(
    meta_data: {
      type: 'Feature',
      properties: {},
      geometry: { type: feature_data['geometry']['type'] }
    }
  )
  puts "created Feature #{feature.inspect}"
  feature_data['geometry']['coordinates'].first.each do |coordinate|
    point = Point.create!(latitude: coordinate.first, longitude: coordinate.last, feature: feature)
    puts "created Points #{point.inspect}"
  end
end


