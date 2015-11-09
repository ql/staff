json.array!(@matches) do |applicant|
  json.extract! applicant, :id, :name, :phone, :email, :status, :salary
  json.url applicant_url(applicant, format: :json)
  json.skills applicant.skills
  json.is_full_match applicant.full_match?(@position)
end
