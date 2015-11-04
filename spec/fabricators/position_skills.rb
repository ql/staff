Fabricator(:position) do
  name { sequence(:position_name) { |i| "position#{i}" } }
  contacts "contacts"
  expires_at { Time.now + 1.week }
  salary { 1000 }
end
