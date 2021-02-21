require 'rails_helper'

RSpec.describe Resident, type: :model do
  describe 'validation' do
    context 'self_message' do
      it 'is invalid with more than 25 words' do
        expect(FactoryBot.build(:resident, self_message: Faker::Lorem.characters(number:26))).to be_invalid
      end
    end
  end

  describe 'association' do
    it 'has many myevents' do
      expect(Resident.reflect_on_association(:myevents).macro).to eq :has_many
    end
  end
end
