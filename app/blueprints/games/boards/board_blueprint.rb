module Games
  module Boards
    class BoardBlueprint < BaseBlueprint
      identifier :id
      fields :board_type

      association :player, blueprint: Users::UserBlueprint, view: :normal
      association :board_columns, blueprint: Games::Boards::BoardColumnBlueprint, name: :cells
    end
  end
end