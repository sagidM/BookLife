class AbstractBooksController < ApplicationController
  def index
    @books = AbstractBook.paginate page: params[:page], per_page: 10
    respond_to do |f|
      f.html
      f.json { render json: @books}
      f.js
    end
  end

  def show

  end
end