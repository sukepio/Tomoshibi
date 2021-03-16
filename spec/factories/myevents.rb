FactoryBot.define do
  factory :myevent do
    title { Faker::Lorem.characters(number: 10) }
    body { Faker::Lorem.characters(number: 15) }
    start { Time.local(Time.new.year, Time.new.month, Time.new.day, Time.new.hour, Time.new.min/30*30) }
    resident
  end
end
