class BooksController < ApplicationController
  
  before_filter :find_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all
    respond_to do |format|
      format.html
      format.xml { render xml: @books.to_xml }
    end
  end
  
  def search
    @books = case params[:by]
      when 'isbn'    then Book.search_by_isbn(params[:query])
      when 'authors' then Book.search_by_authors(params[:query])
      else                Book.search_by_title(params[:query])
    end
    if request.xhr?
      render partial: 'list', locals: {books: @books}
    else
      render action: :index
    end
  end
  
  def show
    @book_reservation = @book.reservation
  end
  
  def new
    if params[:isbn]
      @book = GoogleBooksClient.get(params[:isbn])
      unless @book
        flash[:error] = t('flash.books.new.error')
        @book = Book.new
      end
    else
      @book = Book.new
    end
  end
  
  def create
    @book = Book.new(params[:book])
    if @book.save
      flash[:notice] = t('flash.books.create.notice')
      redirect_to books_path
    else
      render action: :new
    end
  end
  
  def edit
  end
  
  def update
    if @book.update_attributes(params[:book])
      flash[:notice] = t('flash.books.update.notice')
      redirect_to book_path(@book)
    else
      render action: :edit
    end
  end
  
  def destroy
    @book.destroy
    flash[:notice] = t('flash.books.destroy.notice')
    redirect_to books_path
  end
  
  
  private
  
  def find_book
    @book = Book.find(params[:id])
  end

end
