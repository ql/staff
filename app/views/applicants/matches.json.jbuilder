json.array!(@matches) do |position|
  json.extract! position, :id, :name, :expires_at, :salary, :contacts
  json.url position_url(position, format: :json)
  json.skills position.skills
  json.is_full_match position.full_match?(@applicant)
end
