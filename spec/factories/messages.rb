FactoryBot.define do
  factory :message do
    content { Faker::Lorem.characters(number:50) }
    sender { Faker::Lorem.characters(number:10) }
  end
end
