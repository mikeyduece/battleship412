class AddBoardShipToBoardColumns < ActiveRecord::Migration[6.0]
  def change
    add_reference :board_columns, :board_ship
  end
end
