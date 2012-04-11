class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "New book category Added"
      redirect_to root_path
    else
      render :new
    end
  end

  

end
