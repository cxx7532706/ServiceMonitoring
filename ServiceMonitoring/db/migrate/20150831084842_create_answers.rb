class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :survey_id
      t.integer :question_id
      t.string :content
      t.references :feedback, index :true

      t.timestamps
    end
  end
end
