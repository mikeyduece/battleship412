module Api
  module V1
    module Games
      module Ships
        class Update < BaseGameService

          def call(&block)
            play_game!
            yield(Success.new(game), NoTrigger)

          rescue ::Games::InvalidTurnError, ::Games::GameOverError, ::Games::Boards::Ships::InvalidPlacement  => e
            yield(NoTrigger, Failure.new(e.code, e.message))
          rescue StandardError => e
            yield(NoTrigger, Failure.new(500, e.message))
          end

          private

          # Starts the game, runner method
          def play_game!
            # raise ::Games::InvalidTurnError unless correct_player?
            raise ::Games::GameOverError if game.done?

            check_for_winner
            log_shot!
          end

          # Logs the shot, recording a hit or miss in the cell
          def log_shot!
            opponent_cell, own_cell = shoot!
            if opponent_cell.occupied?
              opponent_cell.hit!
              own_cell.hit!
            else
              opponent_cell.miss!
              own_cell.miss!
            end

            game.player_1? ? game.player_2! : game.player_1!
          end

          # Plots the points and shoots
          def shoot!
            column, row = shot_coords
            opponent = opponent_ship_board.board_columns.plot_point(column, row)
            own = shot_board.board_columns.plot_point(column, row)

            return opponent, own
          end

          # Show coordinates entered in through the api
          def shot_coords
            coords = params[:shot][:coord]
            return coords[0], coords[-1]
          end

          # Opposing player's board
          def opponent_ship_board
            game.boards.ships.where.not(player: user).first
          end

          # Checks if the user is the player whose turn it is in the game
          def correct_player?
            player.eql?(user)
          end

          # Updates game with winner and loser if all opposing ships are sunk
          def check_for_winner
            if all_opposing_ships_sunk?
              game.update(winner: user, loser: losing_player, progress: Game.progresses[:done])
            end
          end

          # User object if all thier ships are sunk
          def losing_player
            opponent_ship_board.player
          end

        end
      end
    end
  end
end