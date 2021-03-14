require 'rails_helper'

RSpec.describe Household, type: :model do
  describe 'Validation' do
    subject { household.valid? }

    let!(:other_household) { create(:household, address: Faker::Lorem.characters(number: 5)) }
    let(:household) { build(:household) }

    it 'is valid with valid inputs' do
      is_expected.to eq true
    end

    describe 'Name' do
      it 'is invalid without a head\'s first name' do
        household.head_first_name = ''
        is_expected.to eq false
      end

      it 'is invalid without a head\'s last name' do
        household.head_last_name = ''
        is_expected.to eq false
      end
    end

    describe 'House_damage_situation' do
      it 'is invalid without a house_damage_situation' do
        household.house_damage_situation = ''
        is_expected.to eq false
      end
    end

    describe 'Living_space' do
      it 'is invalid without a living space' do
        household.living_space = ''
        is_expected.to eq false
      end
    end

    describe 'Address' do
      it 'is invalid without an address' do
        household.address = ''
        is_expected.to eq false
      end

      it 'is invalid with a duplicate address' do
        household.address = other_household.address
        is_expected.to eq false
      end
    end
  end

  describe 'Instance method' do
    let!(:household) { build(:household) }

    describe 'Information' do
      it 'returns a head\'s full name as a string and it\'s address' do
        expect(household.information).to eq "日本博　#{household.address}"
      end
    end

    describe 'Full name' do
      it 'returns a head\'s full name as a string' do
        expect(household.full_name).to eq '日本 博'
      end
    end
  end

  describe 'Association' do
    it 'has many residents' do
      expect(Household.reflect_on_association(:residents).macro).to eq :has_many
    end
  end
end
