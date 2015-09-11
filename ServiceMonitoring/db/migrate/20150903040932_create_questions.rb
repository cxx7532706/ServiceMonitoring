class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_type
      t.references :survey, index: true, foreign_key: true
      t.date :created_at
      t.date :updated_at

      t.timestamps
    end
  end
end
