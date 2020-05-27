class Api::V1::Games::BaseGameController < ApplicationController
  before_action :ensure_game

  def ensure_game
    @game ||= current_api_user.games.find_by(id: params[:game_id] || params[:id])
  end

end