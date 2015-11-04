class CreatePositionSkills < ActiveRecord::Migration
  def change
    create_table :position_skills do |t|
      t.string :skillname
      t.references :skill
      t.references :position

#      t.timestamps null: false
    end
  end
end
