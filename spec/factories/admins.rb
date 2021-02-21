FactoryBot.define do
  factory :admin do
    first_name { '太郎' }
    last_name { '山田' }
    first_name_kana { 'ヤマダ' }
    last_name_kana { 'タロウ' }
    email { Faker::Internet.email }
    phone_number { Faker::Lorem.characters(number:11) }
    login_id { Faker::Lorem.characters(number:5) }
    date_of_birth { '2000-01-01' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end