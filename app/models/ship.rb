class Ship < ApplicationRecord
  has_many :board_ships, inverse_of: :ship

  validates :ship_type, uniqueness: true
  enum ship_type: %i[patrol cruiser submarine battleship carrier]
end
