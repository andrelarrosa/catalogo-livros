class BackfillUserOnBooksAndAuthors < ActiveRecord::Migration[8.1]
  OWNER_ID = 1

  # Cópias congeladas das tabelas: sem validações e sem callbacks, imunes a
  # mudanças futuras em app/models.
  class Book < ActiveRecord::Base
    self.table_name = "books"
  end

  class Author < ActiveRecord::Base
    self.table_name = "authors"
  end

  def up
    Book.reset_column_information
    Author.reset_column_information

    Book.where(user_id: nil).update_all(user_id: OWNER_ID)
    Author.where(user_id: nil).update_all(user_id: OWNER_ID)
  end

  def down
    Book.update_all(user_id: nil)
    Author.update_all(user_id: nil)
  end
end
