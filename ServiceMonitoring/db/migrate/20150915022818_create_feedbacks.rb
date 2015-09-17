class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :reference_number
      t.references :survey, index: true
      t.timestamps
    end
  end
end
