FactoryBot.define do
  factory :resident do
    first_name { '花子' }
    last_name { '山田' }
    first_name_kana { 'ハナコ' }
    last_name_kana { 'ヤマダ' }
    phone_number { Faker::Lorem.characters(number:11) }
    login_id { Faker::Lorem.characters(number:5) }
    date_of_birth { '2000-01-01' }
    gender { 0 }
    has_left { false }
    photo_accepted { false}
    information { Faker::Lorem.characters(number:30) }
    self_message { Faker::Lorem.characters(number:25) }
    password { 'password' }
    password_confirmation { 'password' }
    household
  end
end
