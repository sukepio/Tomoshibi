FactoryBot.define do
  factory :household do
    head_first_name { Faker::Lorem.characters(number:2) }
    head_last_name { Faker::Lorem.characters(number:2) }
    living_space { Faker::Lorem.characters(number:5) }
    address { Faker::Lorem.characters(number:15) }
    house_damage_situation { Faker::Lorem.characters(number:15) }
  end
end
