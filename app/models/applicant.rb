class Applicant < ActiveRecord::Base
  has_many :applicant_skills
  has_many :skills, through: :applicant_skills
  validates :first_name, :last_name, :salary, :status, presence: true
  validates :status, inclusion: { in: %w{searching not_searching}}


  validate :validate_skills
  validate :has_contacts

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
end
