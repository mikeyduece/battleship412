class CreateRows < ActiveRecord::Migration[6.0]
  def change
    create_table :rows do |t|
      t.string :name

      t.timestamps
    end

    add_index :rows, :name
  end
end
