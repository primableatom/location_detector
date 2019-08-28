FactoryGirl.define do
  factory :feature do |f|
    f.meta_data {{type: "Feature", properties: {}, geometry: {"type"=>"Polygon"}}}
  end

end
