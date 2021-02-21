require 'rails_helper'

RSpec.describe AdminEvent, type: :model do
  describe 'validation' do
    it 'is invalid without a title' do
      expect(FactoryBot.build(:admin_event)).to be_invalid
    end
  end
end
