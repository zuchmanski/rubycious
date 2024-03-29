class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :url
      t.integer :user_id
      t.integer :points_counter

      t.timestamps
    end
  end
end