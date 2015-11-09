# encoding: utf-8
class Applicant < ActiveRecord::Base
  has_many :applicant_skills
  has_many :skills, through: :applicant_skills
  validates :name, :salary, :status, presence: true
  validates :status, inclusion: { in: %w{searching not_searching}}
  validates_uniqueness_of :email, :phone

  validate :validate_skills
  validate :has_contacts
  validate :name_format

  scope :looking_for_job, -> { where(status: 'searching') }

  def validate_skills
    unless applicant_skills.any?
      errors.add(:skills, "Need to add skills")
    end
  end

  def has_contacts
    unless email || phone
      errors.add(:email, "Email required")
      errors.add(:phone, "Phone required")
    end
  end

  def name_format
    name_parts = name.split(/\s/)
    unless name_parts.size == 3
      errors.add(:name, "Неверный формат: имя должно состоять из трех слов")
    end

    unless name_parts.all? {|part| part =~ /^[а-яА-ЯёЁ-]+$/}
      errors.add(:name, "Неверный формат: имя может включать в себя только кириллические буквы")
    end
  end

  def skill_ids
    applicant_skills.select(:skill_id).map(&:skill_id)
  end

  def matches
    Position.effective.where(id: PositionSkill.where(skill_id: skill_ids).map(&:position_id))
  end

  def full_match?(other)
    skill_ids.sort == other.skill_ids.sort
  end

  def update_skills(new_skills)
    current_skills = applicant_skills.map(&:skill_id)
    removed_skills = current_skills - new_skills
    added_skills = new_skills - current_skills
    self.applicant_skills.where(skill_id: removed_skills).destroy_all &&
    added_skills.each {|id| self.applicant_skills.create(skill_id: id) }
  end
end
