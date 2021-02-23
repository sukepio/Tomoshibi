require 'rails_helper'

RSpec.describe Message, type: :model do
  describe 'validation' do
    subject { message.valid? }

    let!(:message) { create(:message) }

    context 'with valid inputs' do
      it 'can be saved' do
        is_expected.to eq true
      end
    end

    describe 'sender' do
      context 'with a empty sender' do
        it 'is valid' do
          message.sender = ''
          is_expected.to eq false
        end
      end
    end
  end
end
