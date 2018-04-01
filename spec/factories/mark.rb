FactoryBot.define do
  factory :mark do
    line_id line
    lat FFaker::Geolocation.lat
    lng FFaker::Geolocation.lng
    height 1
  end
end
