module Boards::Ships

  def add_ship_placement!(column, row, ship)
    board_column = find_board_column(column, row)
    raise Games::Boards::Ships::InvalidPlacement if board_column.occupied?

    place_ship!(ship, board_column)
    board_column.occupied!
  end

  def remove_ship_placement!(column, row)
    board_column = find_board_column(column, row)
    remove_ship!(board_column)
    board_column.unoccupied!
  end

  def place_ships!(ship_type, coords)
    coords.each do |coord|
      column, row = set_point(coord)
      raise Games::Boards::Ships::InvalidPlacement unless column && row

      add_ship_placement!(column, row, ship_type)
    end
  end

  private

  def find_board_column(column, row)
    board_columns.find_by(column: column, row: row)
  end

  def place_ship!(ship_type, board_column)
    create_board_ship_if_required(ship_type, board_column)
  end

  def remove_ship!(board_column)
    board_column.update_column(:board_ship_id, nil)
  end

  def create_board_ship_if_required(ship_type, board_column)
    ship = Ship.find_or_create_by(ship_type: ship_types(ship_type))
    board_ship = board_ships.find_or_create_by(ship: ship)

    set_ship_board_ship(board_ship&.id, board_column, ship.id)
  end

  def ship_types(ship_type)
    Ship.ship_types[ship_type]
  end

  def set_ship_board_ship(board_ship_id, board_column, ship_id)
    board_column.update_column(:board_ship_id, board_ship_id)
    board_column.board_ship.update_column(:ship_id, ship_id)
  end

  def set_point(coord)
    column = columns.find_by(name: coord[0])
    row = rows.find_by(name: coord[-1])

    return column, row
  end
end