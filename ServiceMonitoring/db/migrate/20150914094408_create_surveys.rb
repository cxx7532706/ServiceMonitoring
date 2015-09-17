class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :name
      t.integer :version
      t.integer :enable_flg
      t.string :provider_name
      t.string :language_avaliable

      t.timestamps
    end
  end
end
