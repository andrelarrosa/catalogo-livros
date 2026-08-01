class AddAuthorRefToBooks < ActiveRecord::Migration[8.1]
  def change
    rename_column :books, :author, :author_name
    add_reference :books, :author, foreign_key: true
  end
end
