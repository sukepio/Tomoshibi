require 'rails_helper'

RSpec.describe Resident, type: :model do
  describe 'validation' do
    subject { resident.valid? }

    let(:resident) { build(:resident) }

    context 'with a valid inputs' do
      it 'can be saved' do
        is_expected.to eq true
      end
    end

    describe 'name' do
      context 'with am empty first_name' do
        it 'is invalid' do
          resident.first_name = ''
          is_expected.to eq false
        end
      end

      context 'with am empty last_name' do
        it 'is invalid' do
          resident.last_name = ''
          is_expected.to eq false
        end
      end

      context 'with am empty first_name_kana' do
        it 'is invalid' do
          resident.first_name_kana = ''
          is_expected.to eq false
        end
      end

      context 'with am empty last_name_kana' do
        it 'is invalid' do
          resident.last_name_kana = ''
          is_expected.to eq false
        end
      end
    end

    describe 'phone_number' do
      context 'with an empty phone_number' do
        it 'is invalid' do
          resident.phone_number = ''
          is_expected.to eq false
        end
      end
    end

    describe 'login_id' do
      context 'with an empty login_id' do
        it 'is invalid' do
          resident.login_id = ''
          is_expected.to eq false
        end
      end
    end

    context 'self_message' do
      it 'is invalid with more than 25 words' do
        resident.self_message = Faker::Lorem.characters(number: 26)
        is_expected.to eq false
      end
    end
  end

  describe 'instance' do
    let!(:resident) { build(:resident) }

    describe 'full_name' do
      it 'returns a conbined string of last_name and first_name' do
        expect(resident.full_name).to eq '山田 花子'
      end
    end

    describe 'full_name_kana' do
      it 'returns a conbined string of last_name_kana and first_name_kana' do
        expect(resident.full_name_kana).to eq 'ヤマダ ハナコ'
      end
    end

    describe 'birthday' do
      it 'returns a date format of Y/-m/-d' do
        expect(resident.birthday).to eq '2000/1/1'
      end
    end
  end

  describe 'association' do
    it 'has many myevents' do
      expect(Resident.reflect_on_association(:myevents).macro).to eq :has_many
    end
  end
end
