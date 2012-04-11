class CommentsController < ApplicationController
  
  def new
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new
    respond_to do |format|
      format.html
      format.js

    end
  end
  
  def create
    @book = Book.find(params[:book_id])
    @comment = @book.comments.new(params[:comment])
    @comment.user_id= current_user.id
   
    if @comment.save
      flash[:notice] = "Thanks for comment"
      respond_to do |format|
        format.html { redirect_to book_path(@book) }
        format.js 
        
      end

    else
      render :new
    end
  end
    
end
