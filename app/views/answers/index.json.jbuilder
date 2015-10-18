json.array!(@answers) do |answer|
  json.extract! answer, :id, :survey_id, :question_id, :client_ref, :content
  json.url answer_url(answer, format: :json)
end
