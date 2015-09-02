class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :survey_id
      t.integer :question_id
      t.integer :client_ref
      t.string :content

      t.timestamps
    end
  end
end
