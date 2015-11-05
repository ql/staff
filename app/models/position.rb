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

  def build_updated_skills(new_skills)
    current_skills = position_skills.map(&:skill_id)
    removed_skills = current_skills - new_skills
    added_skills = new_skills - current_skills
    self.position_skills.where(skill_id: removed_skills).destroy_all &&
      added_skills.each {|id| self.position_skills.new(skill_id: id) }
  end

  def update_skills(new_skills)
    build_updated_skills(new_skills)
    self.position_skills.all?(&:save)
  end
end
