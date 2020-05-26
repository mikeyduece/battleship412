class AddGameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :game, foreign_key: true
  end
end
