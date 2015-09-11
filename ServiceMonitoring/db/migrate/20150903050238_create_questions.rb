class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_type
      t.date :created_at
      t.date :updated_at
      t.references :survey, index: true

      t.timestamps
    end
  end
end
