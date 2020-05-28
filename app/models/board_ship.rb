class BoardShip < ApplicationRecord
  belongs_to :board, inverse_of: :board_ships
  belongs_to :ship, inverse_of: :board_ships

  has_many :board_columns, inverse_of: :board_ship, dependent: :destroy

  validates :ship_id, uniqueness: { scope: :board_id }
end
