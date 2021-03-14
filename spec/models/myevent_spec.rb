require 'rails_helper'

RSpec.describe Myevent, type: :model do
  describe 'validation' do
    subject { myevent.valid? }

    let!(:resident) { FactoryBot.create(:resident) }
    let!(:myevent) { FactoryBot.create(:myevent) }

    it 'is valid with valid inputs' do
      is_expected.to eq true
    end

    describe 'title' do
      it 'is invalid without a title' do
        myevent.title = ''
        is_expected.to eq false
      end
    end

    describe 'resident_id' do
      it 'is invalid without a resident_id' do
        myevent.resident_id = ''
        is_expected.to eq false
      end
    end
  end

  describe 'association' do
    it 'belongs to resident' do
      expect(Myevent.reflect_on_association(:resident).macro).to eq :belongs_to
    end
  end
end
