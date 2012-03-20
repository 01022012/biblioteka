class TagsController < ApplicationController
  
  def show
    @tag = Tag.find(params[:id])
  end
  
  def create
    @book = Book.find(params[:book_id])
    tag = @book.tag_with(params[:name])
    respond_to do |format|
      format.json { render json: tag }
    end
  end
  
end
