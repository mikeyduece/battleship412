module Api
  module V1
    module Games
      module Ships
        class Update < BaseGameService

          def call(&block)
            log_shot!
            yield(Success.new(game), NoTrigger)

          rescue ::Games::Boards::Ships::InvalidPlacement => e
            yield(NoTrigger, Failure.new(e.code, e.message))
          rescue StandardError => e
            yield(NoTrigger, Failure.new(500, e.message))
          end

          private

          def log_shot!
            point = shoot!
            point.occupied? ? point.hit! : point.miss!
          end

          def shoot!
            column, row = shot_coords
            opponent_ship_board.board_columns.plot_point(column, row)
          end

          def shot_coords
            coords = params[:shot][:coord]
            return coords[0], coords[-1]
          end

          def opponent_ship_board
            game.boards.ships.where.not(player: user).first
          end

        end
      end
    end
  end
end