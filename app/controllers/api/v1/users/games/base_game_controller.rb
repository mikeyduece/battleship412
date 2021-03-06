module Api
  module V1
    module Users
      module Games
        class BaseGameController < ApplicationController
          before_action :ensure_game

          private

          def ensure_game
            @game ||= current_api_user.games.find { |game| game.id.eql?(game_id.to_i) }
          end

          def game_id
            params[:game_id] || params[:id]
          end

        end
      end
    end
  end
end