FactoryBot.define do
  factory :admin_event do
    title { Faker::Lorem.characters(number: 10) }
    start { Time.local(Time.new.year, Time.new.month, Time.new.day, Time.new.hour, Time.new.min/30*30) }
  end
end
