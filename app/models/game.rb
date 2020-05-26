class Game < ApplicationRecord
  has_many :players, class_name: 'User', before_add: :validate_number_of_players

  private

  def validate_number_of_players(_user)
    raise StandardError.new('Only 2 players per game') if players.size >= Api::Games::NUMBER_OF_PLAYERS_PER_GAME
  end
end
