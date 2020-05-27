class ColumnRow < ApplicationRecord
  belongs_to :column, inverse_of: :column_rows
  belongs_to :row, inverse_of: :column_rows
  belongs_to :board, inverse_of: :column_rows

  enum status: %i[unoccupied occupied miss hit]

end
