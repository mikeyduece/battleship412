class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :uuid, index: true, null: false, default: ''

      t.timestamps
    end
  end
end
