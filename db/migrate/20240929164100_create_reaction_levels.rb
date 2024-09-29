class CreateReactionLevels < ActiveRecord::Migration[7.0]
  def change
    create_table :reaction_levels do |t|
      t.string :name, null: false
      t.string :emoji, null: false
      t.integer :level, null: false

      t.timestamps
    end

    add_index :reaction_levels, :level, unique: true
  end
end
