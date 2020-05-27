class CreateBoards < ActiveRecord::Migration[6.0]
  def change
    create_table :boards do |t|
      t.integer :board_type, index: true, default: 0
      t.references :game, null: false
      t.references :player, null: false
      t.timestamps
    end

  end

end