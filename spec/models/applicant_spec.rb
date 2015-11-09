#: encoding: utf-8
require 'rails_helper'

RSpec.describe Applicant, type: :model do
  subject { Fabricate.build(:applicant) }

  describe "without skills" do
    it { is_expected.not_to be_valid }
  end

  describe "with skills" do
    before(:each) do
      subject.applicant_skills.new(skill: Fabricate(:skill))
    end
    it { is_expected.to be_valid }
  end

  describe "validations" do
    context "cyrillic 3-part name" do
      before(:each) do
        subject.applicant_skills.new(skill: Fabricate(:skill))
        subject.name = "Иван Васильевич Петров"
      end

      it { is_expected.to be_valid }
    end

    context "non cyrillic name" do
      before(:each) do
        subject.applicant_skills.new(skill: Fabricate(:skill))
        subject.name = "John Doe"
      end

      it { is_expected.not_to be_valid }
    end

    context "non 3-part name" do
      before(:each) do
        subject.applicant_skills.new(skill: Fabricate(:skill))
        subject.name = "Иван Петров"
      end

      it { is_expected.not_to be_valid }
    end
  end

end
