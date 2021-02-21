require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post) }

  describe 'Saving a post' do
    it 'is valid with a title and a body' do
      expect(post).to be_valid
    end
  end
  context 'when a title is empty' do
    it 'returns an empty error message' do
      post.title = ''
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("を入力してください")
    end
  end
  context 'when a body is empty' do
    it 'returns am empty error message' do
      post.body = ''
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("を入力してください")
    end
  end
  context 'when a body does not have more than 20 words' do
    it 'returns a length error message' do
      post.body = Faker::Lorem.characters(number:19)
      expect(post).to be_invalid
      expect(post.errors[:body]).to include("は20文字以上で入力してください")
    end
  end
end
