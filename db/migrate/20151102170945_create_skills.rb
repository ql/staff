class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name

      t.timestamps null: false
      t.index :name, unique: true
    end
  end
end
