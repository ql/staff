task :populate_fakes  => :environment do
  Faker::Config.locale = :ru
  size = 200
  skills = (0...50).map {|_| s = Skill.new(name: Faker::Internet.slug); s.save!; s}
  p 'skills created'
  size.times {
    name = [Faker::Name.male_first_name, Faker::Name.male_middle_name, Faker::Name.male_last_name].join(" ")
    a = Applicant.new(
      name: name,
      salary: ((rand * 100 + 10).to_i * 1000),
      status: ['searching', 'not_searching'][rand(2)],
      email: Faker::Internet.email,
      phone: Faker::PhoneNumber.phone_number
    )
    s = []
    (rand(3) + 2).times {
      s << skills.sample 
    }
    s.uniq.each {|skill| a.applicant_skills.new(skill: skill) }
    a.save!

    p = Position.new(
      name: "#{Faker::Company.name}: #{Faker::Company.profession}",
      salary: ((rand * 100 + 10).to_i * 1000),
      contacts: "foobar",
      expires_at: Time.now + (rand(60) - 30).days
    )
    s = []
    (rand(3) + 2).times {
      s << skills.sample 
    }
    s.uniq.each {|skill| p.position_skills.new(skill: skill) }
    p.save!
  } 
end
