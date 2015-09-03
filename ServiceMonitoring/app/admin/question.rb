ActiveAdmin.register Question do

  menu parent: 'Surveys'

  index do
    column :id
    column :q_type
    column :language
    column :title
    column :options
    column :create_date
  end

end
