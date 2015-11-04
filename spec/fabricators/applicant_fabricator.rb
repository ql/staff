Fabricator(:applicant) do
  first_name "John"
  last_name "Doe"
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  salary { 1000 }
  status "searching"
end
