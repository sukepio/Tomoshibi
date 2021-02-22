require 'rails_helper'

RSpec.describe Myevent, type: :model do
  describe 'validation' do
    subject { myevent.valid? }


    let!(:resident) { FactoryBot.create(:resident) }
    let!(:myevent) { FactoryBot.create(:myevent) }

    context 'with valid inputs' do
      it 'can be saved' do
        is_expected.to eq true
      end
    end

    describe 'title' do
      context 'with am empty title' do
        it 'is invalid' do
          myevent.title = ''
          is_expected.to eq false
        end
      end
    end

    describe 'resident_id' do
      context 'with am empty resident_id' do
        it 'is invalid' do
          myevent.resident_id = ''
          is_expected.to eq false
        end
      end
    end
  end

  describe 'association' do
    it 'belongs to resident' do
      expect(Myevent.reflect_on_association(:resident).macro).to eq :belongs_to
    end
  end
end
