class CreateShips < ActiveRecord::Migration[6.0]
  def change
    create_table :ships do |t|
      t.integer :ship_type, index: true, default: 0

      t.timestamps
    end
  end
end
