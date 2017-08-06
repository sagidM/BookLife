class BooksController < ApplicationController
  def index
    books = Book
                .where(type: 'Ebook')
                .limit(6)
                .union(Book.where(type: 'Audiobook').limit(7))
                .order(:type)
                .includes(abstract_book: :book_series)
                .includes(abstract_book: :authors)
    # p books.map{|b| b.abstract_book_id}
    @ebooks = books.find_all{|b| b.class == Ebook}
    @audiobooks = books.find_all{|b| b.class == Audiobook}
  end

  def show
    @book = Book.find params[:id]

  end
end