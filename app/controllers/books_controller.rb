class BooksController < ApplicationController
  before_action :fill_publishing_houses, only: :new

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

  def new
    @book = Book.new
    @abstract_book = AbstractBook.new
  end

  def create
    @book = Book.new params_book

    if (sbid = params[:same_book_id]).present?
      b = Book.eager_load(:abstract_book).find_by_id(sbid)
      if b.nil?
        flash.now[:notice] = "Book with id = #{sbid} not found"
        fill_publishing_houses
        @abstract_book = AbstractBook.new
        return render new_book_path
      end
      @abstract_book = @book.abstract_book = b.abstract_book
      # @book.abstract_book_id = b.abstract_book_id
    else
      @abstract_book = AbstractBook.new(params.require(:abstract_book).permit(:original_name, :published_at))
      author_ids = params[:author_ids].gsub(' ', '').split(',')
      if @abstract_book.invalid? or author_ids.empty?
        flash.now[:abstract_book_errors] = @abstract_book.errors.messages if @abstract_book.invalid?
        flash.now[:author_ids_errors] = 'Author ids cannot be empty' if author_ids.empty?
        fill_publishing_houses
        return render new_book_path
      end
      ActiveRecord::Base.transaction do
        i = 0
        author_ids.each do |id|
          AbstractBookAuthor.create!(author_id: id, abstract_book: @abstract_book, position: i)
          i += 1
        end
      end
      @book.abstract_book = @abstract_book
    end

    if @book.save
      redirect_to book_path(@book), notice: 'Books is successfully created'
    else
      flash.now[:errors] = @book.errors.messages
      fill_publishing_houses
      render new_book_path
    end
  end

  def show
    @book = Book.find params[:id]
  end

  def destroy
    book = Book.eager_load(:abstract_book).where(id: params[:id])[0]
    notice = nil
    ActiveRecord::Base.transaction do
      book.destroy
      if Book.where(abstract_book: book.abstract_book).empty?
        book.abstract_book.destroy
        notice = "The book '#{book.name}' is completely deleted"
      else
        notice = "The book '#{book.name}' is deleted"
      end
    end
    redirect_to books_path, notice: notice
  end

  private
    def params_book
      if params[:book]
        type = :book
      elsif params[:ebook]
        type = :ebook
      elsif params[:audiobook]
        type = :audiobook
      else
        return
      end
      params.require(type).permit :name, :description, :abstract_book_id, :language,
                                   :background_image, :poster, :remote_poster_url,
                                   :remote_background_image_url, :published_at,
                                   :author_ids, :publishing_house_id, :type
    end

    def params_abstract_book

    end

    def fill_publishing_houses
      @publishing_houses = PublishingHouse.all.reverse_order!
    end
end