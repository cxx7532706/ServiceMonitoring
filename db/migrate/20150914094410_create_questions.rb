class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_type
      t.references :survey, index: true
      t.string :language
      t.string :title

      t.timestamps
    end
  end
end
