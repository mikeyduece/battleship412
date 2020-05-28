module Api
  module V1
    module Games
      class BaseGameService < ApiService
        attr_reader :user, :game, :params

        def self.call(user, game, params = nil, &block)
          new(user, game, params).call(&block)
        end

        def initialize(user, game, params)
          @user = user
          @game = game
          @params = params
        end

        private

        def player
          player = game.turn
          game.send(player)
        end

        def ships
          params[:ships]
        end

        def ship_board
          game_boards(:ships)
        end

        def shot_board
          game_boards(:shots)
        end

        def game_boards(board_type)
          game.boards.send(board_type).find_by(player: user)
        end

        def all_opposing_ships_sunk?
          all_ships.all? { |ship| opponent_ship_board.board_columns.sunk?(ship.id) }
        end

        def all_ships
          Ship.all
        end

      end
    end
  end
end