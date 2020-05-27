require 'rails_helper'

RSpec.describe BoardColumn, type: :model do
  subject { create(:board_column) }
  context :associations do
    it { should belong_to :board }
    it { should belong_to :column }
    it { should belong_to :row }
  end

  context :validations do
    it { should validate_uniqueness_of(:board_id).scoped_to(%i[column_id row_id]) }
  end

end
