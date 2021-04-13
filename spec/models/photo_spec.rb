require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'Validation' do
    subject { photo.valid? }

    let(:photo) { build(:photo) }

    describe 'Image' do
      context 'with an empty image' do
        it 'is invalid' do
          photo.image = ''
          is_expected.to eq false
        end
      end
    end
  end
end
