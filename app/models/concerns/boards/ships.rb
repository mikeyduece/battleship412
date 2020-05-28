module Boards::Ships

  def add_ship_placement!(column, row, ship_type)
    board_column = find_board_column(column, row)
    raise Games::Boards::Ships::InvalidPlacement if board_column.occupied?

    place_ship!(ship_type, board_column)
    board_column.occupied!
  end

  def remove_ship_placement!(column, row)
    board_column = find_board_column(column, row)
    remove_ship!(board_column)
    board_column.unoccupied!
  end

  def place_ships!(ship_type, coords)
    coords.each_with_index do |coord, i|
      column, row = set_point(coord)
      if not_adjacent?(column, row, ship_type, coords, i + 1) || !(column.present? && row.present?)
        raise Games::Boards::Ships::InvalidPlacement
      end

      add_ship_placement!(column, row, ship_type)
    end
  end

  def sunken_ships
    Ship.all.each_with_object({}) do |ship, acc|
      acc[ship.ship_type] = board_columns.sunk?(ship.id)
    end
  end

  private

  def not_adjacent?(column, row, ship_type, coords, index)
    ship = ship(ship_type)
    return false if ship.patrol?

    column_ord = column.name.ord
    row_ord = row.name.to_i
    next_column, next_row = set_point(coords[index])
    return false if (column.name + row.name).eql?(coords[-1])
    return true if not_connected?(column_ord, next_column.name.ord)
    return true if not_connected?(row_ord, next_row.name.to_i)

    false
  end

  def not_connected?(ord, next_ord)
    return true if (ord.chr.eql?('A') && (ord - 1).eql?(64)) || (ord.chr.eql?('J') && (ord + 1).eql?(75))
    return true if (ord.eql?(1) && ord - 1 < 0) || (ord.eql?(10) && ord + 1 > 10)
    return true unless (ord + 1).eql?(next_ord) || (ord - 1).eql?(next_ord) || ord.eql?(next_ord)
  end

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
    ship = ship(ship_type)
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
    return unless coord

    column = columns.find_by(name: coord[0])
    row = rows.find_by(name: coord[-1])

    return column, row
  end

  def ship(ship_type)
    Ship.find_or_create_by(ship_type: ship_types(ship_type))
  end
end