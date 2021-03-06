require 'rails_helper'

RSpec.describe Row, type: :model do
  subject { create(:row) }

  context :associations do
    it { should have_many(:board_columns).inverse_of(:row) }
    it { should have_many(:boards).through(:board_columns) }
  end

  context :validations do
    it { should validate_presence_of(:name) }
  end
end
