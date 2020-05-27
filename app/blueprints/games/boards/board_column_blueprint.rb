module Games
  module Boards
    class BoardColumnBlueprint < BaseBlueprint
      identifier :id
      fields :status

      association :ship, blueprint: Games::Boards::Ships::ShipBlueprint do |board_column, _options|
        board_column.board_ship&.ship
      end

      field :column do |board_column, _options|
        board_column.column.name
      end

      field :row do |board_column, _options|
        board_column.row.name
      end

    end
  end
end