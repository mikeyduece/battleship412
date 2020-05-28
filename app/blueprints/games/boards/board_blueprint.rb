module Games
  module Boards
    class BoardBlueprint < BaseBlueprint
      identifier :id
      fields :board_type

      association :player, blueprint: Users::UserBlueprint, view: :normal
      association :board_columns, blueprint: Games::Boards::BoardColumnBlueprint, name: :cells


      field :sunken_ships, if: ->(_field_name, board, options) { options[:user].eql?(board.player) ? board.shots? : board.ships?  }

    end
  end
end