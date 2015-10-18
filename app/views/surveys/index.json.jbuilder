json.array!(@surveys) do |survey|
  json.extract! survey, :id, :name, :reference_number, :version, :enable_flg, :provider_name, :language_avaliable
  json.url survey_url(survey, format: :json)
end
