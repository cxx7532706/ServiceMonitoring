class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_type
      t.string :survey_id
      t.date :created_at
      t.date :updated_at

      t.timestamps null: false
    end
  end
end
