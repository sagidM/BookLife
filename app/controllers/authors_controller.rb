class AuthorsController < ApplicationController
  def index
    @query = params[:q].to_s
    if @query.empty?
      @authors = Author.all.reverse_order!
    else
      q = "%#{@query.downcase}%"
      @authors = Author.where('lower(first_name) like ? or lower(surname) like ? or lower(patronymic) like ?', q, q, q)
    end
  end

  def new
    @author = Author.new
    flash.now[:errors] = {}
  end

  def create
    @author = Author.new author_params
    if @author.save
      redirect_to author_path(@author), notice: 'Author is added'
    else
      flash.now[:errors] = @author.errors.messages
      render new_author_path
    end
  end

  def show
    id = params[:id]
    @author = Author.where(id: id).eager_load(:abstract_books)[0]
    @books = Book.where(id: @author.abstract_book_ids)
  end

  def destroy
    id = params[:id]
    Author.find(id).destroy
    redirect_to authors_path, notice: "Автор с id = #{id} успешно удален"
  end

  private
    def author_params
      params.require(:author).permit :first_name, :surname, :patronymic, :avatar, :remote_avatar_url, :bdate
    end
end
