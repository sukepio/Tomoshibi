require 'rails_helper'

RSpec.describe Resident, type: :model do
  describe 'Validation' do
    subject { resident.valid? }

    let(:resident) { build(:resident) }

    it 'is valid with valid inputs' do
      is_expected.to eq true
    end

    describe 'Name' do
      it 'is invalid without a first name' do
        resident.first_name = ''
        is_expected.to eq false
      end

      it 'is invalid without a last name' do
        resident.last_name = ''
        is_expected.to eq false
      end

      it 'is invalid without a first name in kana' do
        resident.first_name_kana = ''
        is_expected.to eq false
      end

      it 'is invalid without a last name in kana' do
        resident.last_name_kana = ''
        is_expected.to eq false
      end
    end

    describe 'Phone number' do
      it 'is invalid without a phone number' do
        resident.phone_number = ''
        is_expected.to eq false
      end
    end

    describe 'Login id' do
      it 'is invalid without a login id' do
        resident.login_id = ''
        is_expected.to eq false
      end
    end

    describe 'Date of birth' do
      it 'is invalid without a date of birth' do
        resident.date_of_birth = ''
        is_expected.to eq false
      end
    end

    context 'Self message' do
      it 'is invalid with more than 20 words' do
        resident.self_message = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
  end

  describe 'Modules' do
    let!(:resident) { build(:resident) }

    describe 'Full name' do
      it 'returns a resident\'s full name as a string' do
        expect(resident.full_name).to eq '山田 花子'
      end
    end

    describe 'Full name in kana' do
      it 'returns a resident\'s full name in kana as a string' do
        expect(resident.full_name_kana).to eq 'ヤマダ ハナコ'
      end
    end

    describe 'Birthday' do
      it 'returns a date in the format of Y/-m/-d' do
        expect(resident.birthday).to eq '2000/1/1'
      end
    end
  end

  describe 'Association' do
    it 'can have many myevents' do
      expect(Resident.reflect_on_association(:myevents).macro).to eq :has_many
    end

    it 'can have many photos' do
      expect(Resident.reflect_on_association(:photos).macro).to eq :has_many
    end

    it 'can have many bookmarks' do
      expect(Resident.reflect_on_association(:bookmarks).macro).to eq :has_many
    end

    it 'belongs to household' do
      expect(Resident.reflect_on_association(:household).macro).to eq :belongs_to
    end
  end
end
