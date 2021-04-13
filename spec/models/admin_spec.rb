require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'Validation' do
    subject { admin.valid? }

    let!(:other_admin) { create(:admin) }
    let(:admin) { build(:admin) }

    it 'is valid with a valid inputs' do
      is_expected.to eq true
    end

    describe 'Name' do
      it 'is invalid without a first name' do
        admin.first_name = ''
        is_expected.to eq false
      end

      it 'is invalid without a last name' do
        admin.last_name = ''
        is_expected.to eq false
      end

      it 'is invalid without a first name in kana' do
        admin.first_name_kana = ''
        is_expected.to eq false
      end

      it 'is invalid without a last name in kana' do
        admin.last_name_kana = ''
        is_expected.to eq false
      end
    end

    describe 'Phone number' do
      it 'is invalid without a phone number' do
        admin.phone_number = ''
        is_expected.to eq false
      end
    end

    describe 'Login id' do
      it 'is invalid without a login id' do
        admin.login_id = ''
        is_expected.to eq false
      end
    end

    describe 'Date of birth' do
      it 'is invalid without a date of birth' do
        admin.date_of_birth = ''
        is_expected.to eq false
      end
    end

    describe 'Email' do
      it 'is invalid without an email' do
        admin.email = ''
        is_expected.to eq false
      end

      it 'is invalid with a duplicate email address' do
        admin.email = other_admin.email
        is_expected.to eq false
      end
    end
  end

  describe 'Instance method' do
    let!(:admin) { build(:admin) }

    describe 'Full name' do
      it 'returns a resident\'s full name as a string' do
        expect(admin.full_name).to eq '山田 太郎'
      end
    end
  end

  describe 'Association' do
    it 'can have many posts' do
      expect(Admin.reflect_on_association(:posts).macro).to eq :has_many
    end
  end
end
