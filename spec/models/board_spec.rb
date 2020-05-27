require 'rails_helper'

RSpec.describe Board, type: :model do
  subject { create(:board) }

  context :associations do
    it { should belong_to(:game).inverse_of(:boards) }
    it { should belong_to(:player) }
    it { should have_many(:board_columns).inverse_of(:board).dependent(:destroy) }
    it { should have_many(:columns).through(:board_columns) }
    it { should have_many(:rows).through(:board_columns) }
  end

  context :validations do
  end
end
