module Api
  module V1
    module Games
      module Ships
        class Create < BaseGameService

          def call(&block)
            yield(Success.new(game), NoTrigger)

          rescue StandardError => e
            yield(NoTrigger, Failure.new(500, e.message))
          end

          private

          def place_ships
            ships.each do |ship, coords|
              ship_board.place_ships!(ship, coords)
            end
          end

        end
      end
    end
  end
end