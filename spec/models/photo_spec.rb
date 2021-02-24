require 'rails_helper'

RSpec.describe Photo, type: :model do
  describe 'validation' do
    subject { photo.valid? }

    let!(:resident) { create(:resident) }
    let(:photo) { create(:photo) }

    describe 'images' do
      context 'with an empty images' do
        it 'is invalid' do
          photo.images = ''
          is_expected.to eq false
        end
      end
    end
  end
end
