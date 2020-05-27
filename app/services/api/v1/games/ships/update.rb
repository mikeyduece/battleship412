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
            opponent_cell, own_cell = shoot!

            if opponent_cell.occupied?
              opponent_cell.hit!
              own_cell.hit!
            else
              opponent_cell.miss!
              own_cell.miss!
            end
          end

          def shoot!
            column, row = shot_coords
            opponent = opponent_ship_board.board_columns.plot_point(column, row)
            own = shot_board.board_columns.plot_point(column, row)

            return opponent, own
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