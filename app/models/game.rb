class Game < ApplicationRecord
  belongs_to :player_1, class_name: 'User'
  belongs_to :player_2, class_name: 'User'
  belongs_to :winner, class_name: 'User', optional: true
  belongs_to :loser, class_name: 'User', optional: true

end
