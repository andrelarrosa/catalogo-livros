class AddUserRefToBooksAndAuthors < ActiveRecord::Migration[8.1]
  def change
    add_reference :books, :user, foreign_key: true
    add_reference :authors, :user, foreign_key: true
  end
end
