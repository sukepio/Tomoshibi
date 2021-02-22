FactoryBot.define do
  factory :admin_event do
    title { Faker::Lorem.characters(number:10) }
    
  end
end
