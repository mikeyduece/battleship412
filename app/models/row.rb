class Row < ApplicationRecord
  has_many :board_columns, inverse_of: :row, dependent: :destroy
  has_many :boards, through: :board_columns

  validates :name, presence: true

end
