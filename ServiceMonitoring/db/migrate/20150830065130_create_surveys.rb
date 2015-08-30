class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :reference_number
      t.integer :version
      t.integer :enable_flg
      t.string :provider_name
      t.string :language_avaliable
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
