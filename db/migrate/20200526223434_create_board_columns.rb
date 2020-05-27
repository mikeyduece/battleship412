class CreateBoardColumns < ActiveRecord::Migration[6.0]
  def change
    create_table :board_columns do |t|
      t.references :board, null: false, foreign_key: true
      t.references :column, null: false, foreign_key: true
      t.references :row, null: false, foreign_key: true
      t.integer :status, default: 0, index: true
      t.timestamps
    end

    add_index :board_columns, %i[board_id column_id row_id], unique: true
  end
end
