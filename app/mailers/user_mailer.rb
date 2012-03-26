class UserMailer < ActionMailer::Base

  default from: CONFIG[:from_email]

  def welcome_email(user)
    @user = user
    mail(:to => "#{user.email}", :subject => "Welcome to Library")
  end

end
