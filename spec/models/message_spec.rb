require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'Validation' do
    subject { message.valid? }

    let!(:message) { create(:message) }

    it 'is valid with valid inputs' do
      is_expected.to eq true
    end

    describe 'Sender' do
      it 'is valid without a sender' do
        message.sender = ''
        is_expected.to eq false
      end
    end
  end
end
