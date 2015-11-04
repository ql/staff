json.array!(@applicants) do |applicant|
  json.extract! applicant, :id, :first_name, :last_name, :phone, :email, :status, :salary
  json.url applicant_url(applicant, format: :json)
end
