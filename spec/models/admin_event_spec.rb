require 'rails_helper'

RSpec.describe AdminEvent, type: :model do
  describe 'Validation' do
    subject { admin_event.valid? }

    let!(:admin_event) { FactoryBot.create(:admin_event, end: DateTime.now) }

    it 'is valid with valid inputs' do
      is_expected.to eq true
    end

    describe 'Title' do
      it 'is invalid without a title' do
        admin_event.title = ''
        is_expected.to eq false
      end
    end

    describe 'Start' do
      it 'is invalid without a start time' do
        admin_event.start = ''
        is_expected.to eq false
      end
    end

    describe 'End' do
      it 'is invalid without a end time' do
        admin_event.end = ''
        is_expected.to eq false
      end
    end
  end
end
