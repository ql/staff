class CreatePositionSkills < ActiveRecord::Migration
  def change
    create_table :position_skills do |t|
      t.references :skill
      t.references :position

      t.index [:skill_id, :position_id], unique: true
#      t.timestamps null: false
    end
  end
end
