require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'Validation' do
    subject { meal.valid? }

    let!(:meal) { create(:meal) }

    it 'can be saved with valid inputs' do
      is_expected.to eq true
    end

    describe 'Menu' do
      it 'is invalid without a menu' do
        meal.menu = ''
        is_expected.to eq false
      end
    end

    describe 'Amount' do
      it 'is invalid without an amount' do
        meal.amount = ''
        is_expected.to eq false
      end
    end

    describe 'Start' do
      it 'is invalid without a start time' do
        meal.start = ''
        is_expected.to eq false
      end
    end
  end
end
