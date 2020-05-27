class Api::V1::Games::BaseGameService < ApiService
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
end