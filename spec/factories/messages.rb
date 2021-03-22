FactoryBot.define do
  factory :message do
    content { Faker::Lorem.characters(number: 50) }
    sender { Faker::Lorem.characters(number: 10) }
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/macaron.jpg')) }
  end
end
