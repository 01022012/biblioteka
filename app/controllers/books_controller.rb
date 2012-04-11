class BooksController < ApplicationController
  
  before_filter :get_categories
  before_filter :find_book, only: [:show, :edit, :update, :destroy ]

  def index
    @books = Book.all
    respond_to do |format|
      format.html
      format.xml { render xml: @books.to_xml }
     
    end
  end
  
  
  def feed
  @books = Book.all
  respond_to do |format|
    format.atom
    end
  end
#begin future feature  
  def popular
   #books with highest reservation/no of reads
  end
  
  def featured
   @book=Book.where(:recommendation => true)
  end
  
  def new_book
   @book=Book.publishing_date.Date.today.year
  end
  
  def book_of_day
   @book=Book.all
   @book.randonmize(1).per_day
  end
#end of future feature  

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
  
  def by_cat
    	@books_by_cats = Book.where(:category_id => params[:category_id])
  	render partial: 'cat', locals: {books_by_cats: @books_by_cats}
  end 
  
  def show
    @book_reservation = @book.reservation
    @comments = @book.comments.paginate(page: params[:page])
  end
  
  def new
    if params[:isbn]
      @book = GoogleBooksClient.get(params[:isbn])
      unless @book
        set_flash_message(:error)
        @book = Book.new
      end
    else
      @book = Book.new
    end
  end
  
  def create
  
    @book = Book.new(params[:book])
    if @book.save
      set_flash_message(:notice, {title: @book.title})
      redirect_to books_path
    else
      render action: :new
    end
  end
  
  def edit
  end
  
  def update

    if @book.update_attributes(params[:book])
      set_flash_message(:notice)
      redirect_to book_path(@book)
    else
      render action: :edit
    end
  end
  
  def destroy
    @book.destroy
    set_flash_message(:notice)
    redirect_to books_path
  end
  
  
  private
  
  def find_book
    @book = Book.find(params[:id])
  end

  def get_categories
    @all_categories = Category.all
    @categories = []
    @all_categories.each do |c|
	@categories.push([c.name, c.id])
    end
  end


end
