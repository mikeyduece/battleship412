class CreateColumns < ActiveRecord::Migration[6.0]
  def change
    create_table :columns do |t|
      t.string :name, unique: true, null: false

      t.timestamps
    end
    add_index :columns, :name
  end
end
