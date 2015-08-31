class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.integer :reference_number
      t.datetime :submit_time
      t.references :survey, index: true

      t.timestamps
    end
  end
end
