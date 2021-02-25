require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'validation' do
    subject { photo.valid? }

    let(:photo) { build(:photo) }

    describe 'image' do
      context 'with an empty image' do
        it 'is invalid' do
          photo.image = ''
          is_expected.to eq false
        end
      end
    end
  end
end
