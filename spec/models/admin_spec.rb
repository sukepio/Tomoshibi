require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validation' do
    subject { admin.valid? }

    let!(:other_admin) { FactoryBot.create(:admin) }
    let(:admin) { FactoryBot.build(:admin) }

    describe 'email' do
      context 'when an email is empty' do
        it 'is invalid' do
          admin.email = ''
          is_expected.to eq false
        end
      end

      context 'when an email already exists' do
        it 'is invalid' do
          admin.email = other_admin.email
          is_expected.to eq false
        end
      end
    end


  end
end
