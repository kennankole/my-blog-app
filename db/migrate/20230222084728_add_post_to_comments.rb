class AddPostToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :post, :string
    add_index :comments, :post
  end
end
