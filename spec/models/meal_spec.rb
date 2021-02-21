require 'rails_helper'

RSpec.describe Meal, type: :model do
  describe 'validation' do
    subject { meal.valid? }


    let(:meal) { FactoryBot.build(:meal) }


    it 'is invalid without a menu' do
      meal.menu = ''
      is_expected.to eq false
    end

    it 'is invalid without a amount' do
      meal.amount = ''
      is_expected.to eq false
    end

  end

end
