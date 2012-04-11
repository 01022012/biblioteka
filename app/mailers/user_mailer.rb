class UserMailer < ActionMailer::Base

  default from: CONFIG[:from_email]

  def welcome_email(user)
    @user = user  
    attachments['books.png'] = File.read(Rails.root.join('app', 'assets', 'images', 'books.png'))
    mail(:to => "#{user.email}", :subject => "Welcome to Library")
  end
  
  def reservation_confirmation(user, book)
    @user = user
    @book = book
    mail(:to => "#{user.email}", :subject => "#{book.title} book reservation")
  end
  
   def email_recovery(user)
    @user = user  
    mail(:to => "#{user.email}", :subject => "password recovery")
  end

end
