require 'rails_helper'

RSpec.describe Myevent, type: :model do
  describe 'Validation' do
    subject { myevent.valid? }

    let!(:resident) { FactoryBot.create(:resident) }
    let!(:myevent) { FactoryBot.create(:myevent) }

    it 'is valid with valid inputs' do
      is_expected.to eq true
    end

    describe 'Title' do
      it 'is invalid without a title' do
        myevent.title = ''
        is_expected.to eq false
      end
    end

    describe 'Resident id' do
      it 'is invalid without a resident_id' do
        myevent.resident_id = ''
        is_expected.to eq false
      end
    end

    describe 'Start' do
      it 'is invalid without a start time' do
        myevent.start = ''
        is_expected.to eq false
      end
    end
  end

  describe 'Association' do
    it 'belongs to resident' do
      expect(Myevent.reflect_on_association(:resident).macro).to eq :belongs_to
    end
  end
end
