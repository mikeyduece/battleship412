class CreateBoardShips < ActiveRecord::Migration[6.0]
  def change
    create_table :board_ships do |t|
      t.references :board, null: false, foreign_key: true
      t.references :ship, null: false, foreign_key: true

      t.timestamps
    end

    add_index :board_ships, %i[board_id ship_id], unique: true
  end
end
