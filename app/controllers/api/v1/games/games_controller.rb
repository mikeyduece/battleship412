class Api::V1::Games::GamesController < BaseGameController
  skip_before_action :ensure_game

  def create
    game = Game.new(game_params)
    error = handle_error(game)
    return error_response(error, 404) unless game.save!

    success_response(game: serialized_resource(game, ::Games::GameBlueprint))
  end

  private

  def game_params
    params.require(:game).permit(:uuid, :id, :player_1_id, :player_2_id)
  end

end