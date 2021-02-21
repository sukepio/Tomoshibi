require 'rails_helper'

RSpec.describe Message, type: :model do

  context 'validation' do
    it 'is valid without a sender' do
      expect(FactoryBot.build(:message, sender: '')).to be_invalid
    end
  end
end
