class Board < ApplicationRecord
  belongs_to :game, inverse_of: :boards
  belongs_to :player, class_name: 'User', foreign_key: :player_id

  has_many :board_columns, inverse_of: :board, dependent: :destroy
  has_many :columns, through: :board_columns
  has_many :rows, through: :board_columns

  after_commit :ensure_grid, on: :create

  enum board_type: %i[ships shots]

  def add_ship_placement!(column, row)
    board_column = find_board_column(column, row)
    board_column.occupied!
  end

  def remove_ship_placement!(column, row)
    board_column = find_board_column(column, row)
    board_column.unoccupied!
  end

  private

  def find_board_column(column, row)
    board_columns.find_by(column: column, row: row)
  end

  def ensure_grid
    Column.find_each do |c|
      Row.find_each { |r| board_columns.create(column: c, row: r) }
    end
    save!
  end

end
