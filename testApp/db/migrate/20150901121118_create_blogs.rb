class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :context
      t.date :created_at
      t.date :updated_at

      t.timestamps null: false
    end
  end
end
