# encoding: utf-8
Fabricator(:applicant) do
  name "Иван Иванович Иванов"
  email { sequence(:email) { |i| "user#{i}@example.com" } }
  salary { 1000 }
  status "searching"
end
