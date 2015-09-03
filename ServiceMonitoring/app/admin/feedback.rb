ActiveAdmin.register Feedback do

  index do
    column :id
    column :reference_number
    column :submit_time
    column :survey_id
  end

end
