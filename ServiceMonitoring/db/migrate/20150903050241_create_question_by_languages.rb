class CreateQuestionByLanguages < ActiveRecord::Migration
  def change
    create_table :question_by_languages do |t|
      t.string :language
      t.string :title
      t.string :options
      t.date :created_at
      t.date :updated_at
      t.references :question, index: true

      t.timestamps
    end
  end
end
