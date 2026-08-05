require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = books(:one)
    sign_in_as users(:one)
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get new" do
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    assert_difference("Book.count") do
      post books_url, params: { book: { author_id: @book.author_id, read: @book.read, title: @book.title, year: @book.year } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    patch book_url(@book), params: { book: { author_id: @book.author_id, read: @book.read, title: @book.title, year: @book.year } }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    assert_difference("Book.count", -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end

  test "should not show a book owned by another user" do
    sign_in_as users(:two)

    # show_exceptions = :rescuable no ambiente de teste: o RecordNotFound
    # vira resposta 404 em vez de estourar como exceção.
    get book_url(@book)
    assert_response :not_found
  end

  test "filters books by title" do
    get books_url, params: { q: "casmurro" }

    assert_response :success
    assert_select "#books", text: /Dom Casmurro/
    assert_select "#books", text: /A Hora da Estrela/, count: 0
  end

  test "filters books by read status" do
    get books_url, params: { read: "read" }
    assert_select "#books", text: /A Hora da Estrela/
    assert_select "#books", text: /Dom Casmurro/, count: 0

    get books_url, params: { read: "unread" }
    assert_select "#books", text: /Dom Casmurro/
    assert_select "#books", text: /A Hora da Estrela/, count: 0
  end

  test "combines title and read filters" do
    get books_url, params: { q: "Dom", read: "read" }

    assert_response :success
    assert_select "#books div[id^=book_]", count: 0
  end

  test "blank filters list everything" do
    get books_url, params: { q: "", read: "" }

    assert_select "#books div[id^=book_]", count: 2
  end

  test "index only lists the current user's books" do
    sign_in_as users(:two)

    get books_url
    assert_response :success
    assert_select "#books div[id^=book_]", count: 0
  end
end
