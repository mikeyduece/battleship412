class Board < ApplicationRecord
  belongs_to :game, inverse_of: :boards
  belongs_to :player, class_name: 'User', foreign_key: :player_id

  has_many :board_columns, inverse_of: :board, dependent: :destroy
  has_many :columns, through: :board_columns
  has_many :rows, through: :board_columns

  after_commit :ensure_grid, on: :create

  enum board_type: %i[ships shots]

  def add_ship_placement!(column, row, ship)
    board_column = find_board_column(column, row)
    board_column.ship = ship
    board_column.occupied!
  end

  def remove_ship_placement!(column, row)
    board_column = find_board_column(column, row)
    board_column.unoccupied!
  end

  def place_ships!(ship, coords)
    coords.each do |coord|
      column, row = set_point(coord)
      add_ship_placement!(column, row, ship)
    end
  end

  private

  def set_point(coord)
    column = columns.find_by(name: coord[0])
    row = rows.find_by(name: coord[-1])

    return column, row
  end

  def find_board_column(column, row)
    board_columns.find_by(column: column, row: row)
  end

  def ensure_grid
    Column.find_each do |c|
      Row.find_each { |r| board_columns.create(column: c, row: r) }
    end
    save!
  end

end
