class Game < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  belongs_to :winner, class_name: 'User', optional: true
  belongs_to :loser, class_name: 'User', optional: true

  has_many :boards, inverse_of: :game, dependent: :destroy

  before_create :ensure_uuid
  before_commit :ensure_boards, on: :create

  enum progress: %i[waiting in_progress done]
  enum turn: %i[player_1 player_2]

  def player_1_ship_board
    player_boards(player_1, :ships)
  end

  def player_2_ship_board
    player_boards(player_2, :ships)
  end

  def player_1_shot_board
    player_boards(player_1, :shots)
  end

  def player_2_shot_board
    player_boards(player_2, :shots)
  end

  private

  def ensure_boards
    [player_1, player_2].each do |player|
      boards.create(player: player, board_type: board_types(:ships))
      boards.create(player: player, board_type: board_types(:shots))
    end
  end

  def board_types(board_type)
    Board.board_types[board_type]
  end

  def player_boards(player, board_type)
    boards.find_by(player: player, board_type: board_type)
  end

  def ensure_uuid
    self.uuid = SecureRandom.hex(6)
  end

end
