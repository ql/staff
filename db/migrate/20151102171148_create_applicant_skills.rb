class CreateApplicantSkills < ActiveRecord::Migration
  def change
    create_table :applicant_skills do |t|
      t.references :skill
      t.references :applicant

      t.index [:skill_id, :applicant_id], unique: true

#      t.timestamps null: false
    end
  end
end
