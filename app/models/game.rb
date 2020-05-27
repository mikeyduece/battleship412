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

  def ensure_uuid
    self.uuid = SecureRandom.hex(6)
  end

end
