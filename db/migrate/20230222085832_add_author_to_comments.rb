class AddAuthorToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :author, :string
    add_index :comments, :author
  end
end
