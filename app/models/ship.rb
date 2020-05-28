class Ship < ApplicationRecord
  has_many :board_ships, inverse_of: :ship

  validates :ship_type, uniqueness: true
  enum ship_type: %i[patrol cruiser submarine battleship carrier]

  def length
    case ship_type.to_sym
    when :patrol then 1
    when :cruiser then 2
    when :submarine then 3
    when :battleship then 4
    when :carrier then 5
    end
  end
end
