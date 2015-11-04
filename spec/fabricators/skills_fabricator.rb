Fabricator(:skill) do
  name { sequence(:skill_name) { |i| "skill#{i}" } }
end
