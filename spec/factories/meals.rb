FactoryBot.define do
  factory :meal do
    menu { Faker::Lorem.characters(number: 10) }
    amount { Faker::Number.number(digits: 3) }
    start { Time.local(Time.new.year, Time.new.month, Time.new.day, Time.new.hour, Time.new.min/30*30) }
  end
end
