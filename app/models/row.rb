class Row < ApplicationRecord
  has_many :board_columns, inverse_of: :row, dependent: :destroy

  validates :name, presence: true

end
