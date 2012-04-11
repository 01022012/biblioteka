class SiteController < ApplicationController

  def index
    @categories = Category.all
    respond_to do |format|
      format.html
      format.xml {render xml: @categories.to_xml }
    end
  end

end
