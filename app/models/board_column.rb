class BoardColumn < ApplicationRecord
  belongs_to :board, inverse_of: :board_columns
  belongs_to :column, inverse_of: :board_columns
  belongs_to :row, inverse_of: :board_columns

  enum status: %i[unoccupied occupied hit miss]

  validates :board_id, uniqueness: { scope: %i[column_id row_id] }

end