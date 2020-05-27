class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :uuid, index: true, null: false, default: ''
      t.references :player_1
      t.references :player_2
      t.references :winner
      t.references :loser
      t.integer :progress, default: 0, index: true
      t.integer :turn, default: 0, index: true

      t.timestamps
    end

  end
end
