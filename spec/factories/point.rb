FactoryGirl.define do
  factory :point do |p|
    p.latitude 50.123232
    p.longitude 9.132322
    p.association(:feature)
  end

end
