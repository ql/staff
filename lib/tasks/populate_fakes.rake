task :populate_fakes  => :environment do
  size = 50
  skills = (0...size/2).map {|_| s = Skill.new(name: Faker::Internet.slug); s.save!; s}
  size.times {
    a = Applicant.new(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      salary: ((rand * 100 + 10).to_i * 1000),
      status: ['searching', 'not_searching'][rand(2)],
      email: Faker::Internet.email
    )
    (rand(3) + 2).times {
      a.applicant_skills.new(skill: skills.sample)
    }
    a.save!

    p = Position.new(
      name: "#{Faker::Company.name}: #{Faker::Company.profession}",
      salary: ((rand * 100 + 10).to_i * 1000),
      contacts: "foobar",
      expires_at: Time.now + (rand(60) - 30).days
    )
    (rand(7) + 3).times {
      p.position_skills.new(skill: skills.sample)
    }
    p.save!
  } 
end
