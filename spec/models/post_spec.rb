require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Validation' do
    subject { post.valid? }

    let!(:admin) { create(:admin) }
    let(:post) { build(:post) }


    context 'when a title and a body are valid' do
      it 'can be saved' do
        post.admin_id = admin.id
        is_expected.to eq true
      end
    end

    describe 'title' do
      it 'is invalid without a title' do
        post.title = ''
        is_expected.to eq false
      end
    end

    describe 'body' do
      it 'is invalid without a body' do
        post.body = ''
        is_expected.to eq false
      end

      it 'is invalid with less than 20 words' do
        post.body = Faker::Lorem.characters(number:19)
        is_expected.to eq false
      end

      it 'is valid with 20 words or more' do
        post.admin_id = admin.id
        post.body = Faker::Lorem.characters(number:20)
        is_expected.to eq true
      end
    end
  end

  describe 'association' do
    it 'belongs to admin' do
      expect(Post.reflect_on_association(:admin).macro).to eq :belongs_to
    end
  end
end
