class Board < ApplicationRecord
  include Boards::Ships

  belongs_to :game, inverse_of: :boards
  belongs_to :player, class_name: 'User', foreign_key: :player_id

  has_many :board_columns, inverse_of: :board, dependent: :destroy
  has_many :board_ships, inverse_of: :board, dependent: :destroy
  has_many :columns, through: :board_columns
  has_many :rows, through: :board_columns

  after_commit :ensure_grid, on: :create

  enum board_type: %i[ships shots]

  scope :sunken_ships, -> {
    ship_ids = joins(:board_columns, board_ships: :ship)
                 .where(board_columns: {status: BoardColumn.statuses[:hit]})
                 .pluck('board_ships.ship_id')
    ships = Ship.where(id: ship_ids)
  }

  private

  def ensure_grid
    Column.find_each do |c|
      Row.find_each { |r| board_columns.create(column: c, row: r) }
    end
    save!
  end

end
