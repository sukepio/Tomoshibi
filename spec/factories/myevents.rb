FactoryBot.define do
  factory :myevent do
    title { Faker::Lorem.characters(number:10) }
    resident
  end
end
