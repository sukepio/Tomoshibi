FactoryBot.define do
  factory :admin_event do
    title { Faker::Lorem.characters(number: 10) }
    start { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
