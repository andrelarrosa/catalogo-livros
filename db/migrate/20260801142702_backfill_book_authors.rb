class BackfillBookAuthors < ActiveRecord::Migration[8.1]
  class Book < ActiveRecord::Base
    self.table_name = "books"
  end

  class Author < ActiveRecord::Base
    self.table_name = "authors"
  end

  def up
    Book.reset_column_information

    Book.where(author_id: nil).find_each do |book|
      next if book.author_name.blank?

      author = Author.find_or_create_by!(name: book.author_name.strip)
      book.update_column(:author_id, author.id)
    end
  end

  def down
    Book.update_all(author_id: nil)
  end
end
