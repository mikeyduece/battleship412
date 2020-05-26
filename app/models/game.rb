class Game < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  belongs_to :winner, class_name: 'User', optional: true
  belongs_to :loser, class_name: 'User', optional: true

  before_create :ensure_uuid

  private

  def ensure_uuid
    self.uuid = SecureRandom.hex(6)
  end

end
