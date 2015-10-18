json.array!(@feedbacks) do |feedback|
  json.extract! feedback, :id, :reference_number, :survey
  json.url feedback_url(feedback, format: :json)
end
