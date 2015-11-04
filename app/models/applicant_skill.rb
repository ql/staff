class ApplicantSkill < ActiveRecord::Base
  belongs_to :skill 
  belongs_to :applicant
end
