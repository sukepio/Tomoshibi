FactoryBot.define do
  factory :admin do
    first_name { '太郎' }
    last_name { '山田' }
    first_name_kana { 'ヤマダ' }
    last_name_kana { 'タロウ' }
    email { 'test1@example.com' }
    phone_number { '00011112222' }
    login_id { 'sample1' }
    date_of_birth { '2000-01-01' }
    encrypted_password { 'password' }
  end
end