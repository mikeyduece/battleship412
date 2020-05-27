class Column < ApplicationRecord
  has_many :board_columns, inverse_of: :column, dependent: :destroy
  has_many :boards, through: :board_columns
  has_many :column_rows, inverse_of: :column, dependent: :destroy
  has_many :rows, through: :column_rows

  validates :name, presence: true

end
