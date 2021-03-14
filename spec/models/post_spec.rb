require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validation' do
    subject { post.valid? }

    let!(:admin) { create(:admin) }
    let(:post) { build(:post) }

    it 'is valid with valid inputs ' do
      post.admin_id = admin.id
      is_expected.to eq true
    end

    describe 'Title' do
      it 'is invalid without a title' do
        post.title = ''
        is_expected.to eq false
      end
    end

    describe 'Admin_id' do
      it 'is invalid without an admin id' do
        post.admin_id = ""
        is_expected.to eq false
      end
    end

    describe 'Body' do
      it 'is invalid without a body' do
        post.body = ''
        is_expected.to eq false
      end

      it 'is invalid with less than 20 words' do
        post.body = Faker::Lorem.characters(number: 19)
        is_expected.to eq false
      end

      it 'is valid with 20 words or more' do
        post.admin_id = admin.id
        post.body = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
    end
  end

  describe 'Association' do
    it 'belongs to admin' do
      expect(Post.reflect_on_association(:admin).macro).to eq :belongs_to
    end
  end
end
