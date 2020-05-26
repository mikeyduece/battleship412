require 'rails_helper'

RSpec.describe Game, type: :model do
  subject { create(:game) }

  context :validations do
    it { should belong_to(:player_1) }
    it { should belong_to(:player_2) }

  end
end
