class FeaturesPresenter

  def self.from_array(features)
    features.collect do |feature|
      new(feature)
    end
  end

  def initialize(feature)
    @feature = feature
  end

  def as_json(*)
    {
      id: @feature.id,
      type: @feature.meta_data['type'],
      properties: @feature.meta_data['properties'],
      geometry: {
        type: @feature.meta_data['geometry']['type'],
        coordinates: @feature.points.collect { |p| [p.latitude, p.longitude] }
      }
    }
  end

end
