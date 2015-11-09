json.array!(@applicants) do |applicant|
  json.extract! applicant, :id, :name, :phone, :email, :status, :salary
  json.url applicant_url(applicant, format: :json)
end
