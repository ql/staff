class Position < ActiveRecord::Base
  has_many :position_skills
  has_many :skills, through: :position_skills
  validates :name, :salary, :expires_at, :contacts, presence: true

  validate :validate_skills

  default_scope { where("expires_at > ?", Time.now).order('salary desc') }

  def validate_skills
    unless position_skills.any?
      errors.add(:skills, "Need to add skills")
    end
  end

  def skill_ids
    position_skills.select(:skill_id).map(&:skill_id)
  end

  def matches
    Applicant.where(id: ApplicantSkill.where(skill_id: skill_ids).map(&:applicant_id))
  end

  def full_match?(other)
    skill_ids.sort == other.skill_ids.sort
  end
end
