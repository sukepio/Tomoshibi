require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'validation' do
    subject { meal.valid? }


    let!(:meal) { create(:meal) }


    context 'with valid inputs' do
      it 'can be saved' do
        is_expected.to eq true
      end
    end

    describe 'menu' do
      context 'with am empty menu' do
        it 'is invalid' do
          meal.menu = ''
          is_expected.to eq false
        end
      end
    end

    describe 'amount' do
      context 'with am empty amount' do
        it 'is invalid' do
          meal.amount = ''
          is_expected.to eq false
        end
      end
    end
  end

end
