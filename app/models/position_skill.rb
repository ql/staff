class PositionSkill < ActiveRecord::Base
  belongs_to :skill 
  belongs_to :position
end
