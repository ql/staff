require 'rails_helper'

RSpec.describe Position, type: :model do
  subject { Fabricate.build(:position) }

  describe "without skills" do
    it { is_expected.not_to be_valid }
  end

  describe "with skills" do
    before(:each) do
      subject.position_skills.new(skill: Fabricate(:skill))
    end
    it { is_expected.to be_valid }
  end
end
