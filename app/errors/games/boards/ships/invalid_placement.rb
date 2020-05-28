module Games
  module Boards
    module Ships
      class InvalidPlacement < ::Base
        def code
          super
        end

        def message
          I18n.t('api.games.boards.ships.errors.invalid_placement')
        end
      end
    end
  end
end