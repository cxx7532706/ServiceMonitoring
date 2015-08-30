json.array!(@questions) do |question|
  json.extract! question, :id, :type, :language, :title, :options, :create_date
  json.url question_url(question, format: :json)
end
