ActiveAdmin.register Question do

  index do
    column :id
    column :q_type
    column :language
    column :title
    column :options
    column :create_date
  end

end
