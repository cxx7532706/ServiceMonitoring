ActiveAdmin.register Survey do

  index do
    column :id
    column :name
    column :reference_number
    column :version
    column :enable_flg
    column :provider_name
    column :language_available
    column :start_date
    column :end_date
  end

  show do

  end
end
