class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.string :reference_number
      t.integer :version
      t.integer :enable_flg
      t.string :provider_name
      t.string :language_avaliable
      t.date :created_at
      t.date :updated_at

      t.timestamps null: false
    end
  end
end
