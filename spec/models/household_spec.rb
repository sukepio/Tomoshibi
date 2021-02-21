require 'rails_helper'

RSpec.describe Household, type: :model do
  subject { household.valid? }


  let!(:other_household) { FactoryBot.create(:household) }
  let(:household) { FactoryBot.build(:household) }

  describe 'validation' do

    it 'is invalid without a head_first_name' do
      household.head_first_name = ''
      is_expected.to eq false
    end

    it 'is invalid without a head_last_name' do
      household.head_last_name = ''
      is_expected.to eq false
    end

    it 'is invalid without a house_damage_situation' do
      household.house_damage_situation = ''
      is_expected.to eq false
    end

    it 'is invalid without a living_space' do
      household.living_space = ''
      is_expected.to eq false
    end

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
