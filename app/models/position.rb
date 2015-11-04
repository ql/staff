class Position < ActiveRecord::Base
  has_many :position_skills
  has_many :skills, through: :position_skills
  validates :name, :salary, :expires_at, :contacts, presence: true

  validate :validate_skills

  def validate_skills
    unless position_skills.any?
      errors.add(:skills, "Need to add skills")
    end
  end
end
