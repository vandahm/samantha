class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.text :body
      t.references :author
      t.references :category
      t.timestamps
    end

    add_index :posts, :slug
  end
end
