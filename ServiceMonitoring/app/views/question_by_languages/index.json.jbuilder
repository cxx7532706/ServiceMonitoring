json.array!(@question_by_languages) do |question_by_language|
  json.extract! question_by_language, :id, :language, :title, :options, :created_at, :updated_at, :question_id
  json.url question_by_language_url(question_by_language, format: :json)
end
