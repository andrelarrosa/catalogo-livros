json.extract! book, :id, :title, :author_id, :year, :read, :created_at, :updated_at
json.author_name book.author.name
json.url book_url(book, format: :json)