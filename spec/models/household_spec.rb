require 'rails_helper'

RSpec.describe Household, type: :model do
  describe 'validation' do
    subject { household.valid? }


    let!(:other_household) { FactoryBot.create(:household) }
    let(:household) { FactoryBot.build(:household) }


    context 'name' do
      it 'is invalid without a head_first_name' do
        household.head_first_name = ''
        is_expected.to eq false
      end

      it 'is invalid without a head_last_name' do
        household.head_last_name = ''
        is_expected.to eq false
      end
    end

    context 'house_damage_situation' do
      it 'is invalid without a house_damage_situation' do
        household.house_damage_situation = ''
        is_expected.to eq false
      end
    end

    context 'living_space' do
      it 'is invalid without a living_space' do
        household.living_space = ''
        is_expected.to eq false
      end
    end

    context 'emial' do
      it 'is invalid without an email' do
        household.address = ''
        is_expected.to eq false
      end

      it 'is invalid with an email that already exists' do
        household.address = other_household.address
        is_expected.to eq false
      end
    end
  end

  describe 'association' do
    it 'has many residents' do
      expect(Household.reflect_on_association(:residents).macro).to eq :has_many
    end
  end
end
