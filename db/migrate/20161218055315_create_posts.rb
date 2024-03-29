class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :user, foreign_key: true
      t.text :text
      t.string :category

      t.timestamps
    end
  end
end
