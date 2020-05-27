module Games
  module Boards
    module Ships
      class BoardShipBlueprint < BaseBlueprint
        identifier :id

        association :ship, blueprint: Games::Boards::Ships::ShipBlueprint
      end
    end
  end
end