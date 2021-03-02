require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validation' do
    subject { admin.valid? }

    let!(:other_admin) { create(:admin) }
    let(:admin) { build(:admin) }

    context 'with valid inputs' do
      it 'can be saved' do
        is_expected.to eq true
      end
    end

    describe 'email' do
      context 'when an email is empty' do
        it 'is invalid' do
          admin.email = ''
          is_expected.to eq false
        end
      end

      context 'when an email already exists' do
        it 'is invalid' do
          admin.email = other_admin.email
          is_expected.to eq false
        end
      end
    end
  end

  describe 'instance' do
    let!(:admin) { build(:admin) }

    describe 'full_name' do
      it 'returns a conbined string of last_name and first_name' do
        expect(admin.full_name).to eq '山田 太郎'
      end
    end
  end

  describe 'association' do
    it 'has many posts' do
      expect(Admin.reflect_on_association(:posts).macro).to eq :has_many
    end
  end
end
