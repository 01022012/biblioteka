class PasswordsController < ApplicationController
  def create
  user = User.find_by_email(params[:email])
    if user
     UserMailer.email_recovery(@user).deliver
      redirect_to root_path
    else
      flash[:error] = "Email not found on our system"
      render :new
    end
  
  end

  def update
  end

end
