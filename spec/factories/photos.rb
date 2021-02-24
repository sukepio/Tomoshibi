FactoryBot.define do
  factory :photo do
    images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/apple_pie.jpg')) }
    resident
  end
end
