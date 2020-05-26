class User < ApplicationRecord
  include Authentication::Doorkeeper

  has_many :player_1_games, class_name: 'Game', foreign_key: :player_1_id
  has_many :player_2_games, class_name: 'Game', foreign_key: :player_2_id


  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true, case_sensitive: false

  def games
    player_1_games | player_2_games
  end
end
