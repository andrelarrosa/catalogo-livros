class RemoveAuthorNameFromBooks < ActiveRecord::Migration[8.1]
  def change
    remove_column :books, :author_name, :string
    change_column_null :books, :author_id, false
  end
end
