require 'rails_helper'

RSpec.describe Resident, type: :model do
  describe 'association' do
    it 'has many myevents' do
      expect(Resident.reflect_on_association(:myevents).macro).to eq :has_many
    end
  end
end
