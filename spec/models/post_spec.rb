require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { post.valid? }

  let(:post) { FactoryBot.build(:post) }

  describe 'Saving a post' do
    it 'is valid with a title and a body' do
      is_expected.to eq true
    end
  end

  describe 'Validation' do

    describe 'title' do
      context 'when a title is empty' do
        it 'is invalid' do
          post.title = ''
          is_expected.to eq false
        end
      end
    end

    describe 'body' do
      context 'when a body is empty' do
        it 'is invalid' do
          post.body = ''
          is_expected.to eq false
        end
      end

      context 'when a body has less than 20 words' do
        it 'is invalid' do
          post.body = Faker::Lorem.characters(number:19)
          is_expected.to eq false
        end
      end

      context 'when a body has 20 words or more' do
        it 'is valid' do
          post.body = Faker::Lorem.characters(number:20)
          is_expected.to eq true
        end
      end
    end

  end
end
