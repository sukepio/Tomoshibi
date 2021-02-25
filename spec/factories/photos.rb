FactoryBot.define do
  factory :photo do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/apple_pie.jpg')) }
    resident
  end
end
