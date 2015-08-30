class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_type
      t.string :language
      t.string :title
      t.string :options
      t.date :create_date

      t.timestamps
    end
  end
end
