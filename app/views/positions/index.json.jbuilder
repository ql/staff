json.array!(@positions) do |position|
  json.extract! position, :id, :name, :expires_at, :salary, :contacts
  json.url position_url(position, format: :json)
end
