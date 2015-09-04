json.array!(@questions) do |question|
  json.extract! question, :id, :q_type, :survey_id, :created_at, :updated_at, :survey_id
  json.url question_url(question, format: :json)
end
