class CreateApplicantSkills < ActiveRecord::Migration
  def change
    create_table :applicant_skills do |t|
      t.string :skillname
      t.references :skill
      t.references :applicant

#      t.timestamps null: false
    end
  end
end
