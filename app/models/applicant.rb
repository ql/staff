class Applicant < ActiveRecord::Base
  has_many :applicant_skills
  has_many :skills, through: :applicant_skills
  validates :first_name, :last_name, :salary, :status, presence: true
  validates :status, inclusion: { in: %w{searching not_searching}}

  validate :validate_skills
  validate :has_contacts

  default_scope { where(status: 'searching').order('salary asc') }

  def validate_skills
    unless applicant_skills.any?
      errors.add(:applicant_skills, "Need to add skills")
    end
  end

  def has_contacts
    unless email || phone
      errors.add(:email, "Email required")
      errors.add(:phone, "Phone required")
    end
  end

  def skill_ids
    applicant_skills.select(:skill_id).map(&:skill_id)
  end

  def matches
    Position.where(id: PositionSkill.where(skill_id: skill_ids).map(&:position_id))
  end

  def full_match?(other)
    skill_ids.sort == other.skill_ids.sort
  end
end
