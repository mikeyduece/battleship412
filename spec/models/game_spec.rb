require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { create(:game) }

  context :validations do
    it { should belong_to(:player_1) }
    it { should belong_to(:player_2) }
  end

  context :instance_methods do
    xit 'should not allow a player to place ships when not their turn' do
    end
  end
end
