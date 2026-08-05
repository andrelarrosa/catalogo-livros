class MakeUserRequiredOnBooksAndAuthors < ActiveRecord::Migration[8.1]
  def change
    change_column_null :books, :user_id, false
    change_column_null :authors, :user_id, false
  end
end
