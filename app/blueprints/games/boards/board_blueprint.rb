module Games
  module Boards
    class BoardBlueprint < BaseBlueprint
      identifier :id
      fields :board_type

      association :player, blueprint: Users::UserBlueprint, view: :normal
      association :board_columns, blueprint: Games::Boards::BoardColumnBlueprint, name: :cells


      field :sunken_ships do |board, _options|
        Ship.all.each_with_object({}) do |ship, acc|
          acc[ship.ship_type] = board.board_columns.sunk?(ship.id)
        end
      end

    end
  end
end