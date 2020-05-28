class BoardColumn < ApplicationRecord
  belongs_to :board, inverse_of: :board_columns
  belongs_to :column, inverse_of: :board_columns
  belongs_to :row, inverse_of: :board_columns
  belongs_to :board_ship, inverse_of: :board_columns, optional: true

  validates :board_id, uniqueness: { scope: %i[column_id row_id] }

  enum status: %i[unoccupied occupied hit miss]

  scope :plot_point, ->(column, row) {
    joins(:column, :row).find_by(columns: { name: column }, rows: { name: row })
  }

  def self.sunk?(ship_id)
    ship = Ship.find(ship_id)
    hits = joins(:board_ship).where(board_ships: { ship_id: ship.id }).hit

    ship.length.eql?(hits.length)
  end

end
