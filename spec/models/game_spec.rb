require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { create(:game) }

  context :validations do
    it { should have_many(:players) }

    it 'should validate number of players' do
      subject.players = create_list(:user, 2)
      user = create(:user)

      expect(subject).to be_valid
      expect(subject.players.count).to eq(2)
      expect { subject.players << user }.to raise_error(StandardError)
      expect(subject.players.count).to eq(2)
    end

  end
end
