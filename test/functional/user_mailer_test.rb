require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  
  setup do
    @user = Factory(:user)
    @book = Factory(:book, title: 'Rails recipes')
  end
  
  should "deliver welcome email" do
    mail = UserMailer.welcome_email(@user)
    assert_equal [@user.email], mail.to
    assert_equal 'Welcome to Library', mail.subject
    assert_match /Sign in at:.+\/session\/new/, mail.body.encoded
  end
  
  should "deliver reservation confirmation" do
    mail = UserMailer.reservation_confirmation(@user, @book)
    assert_equal [@user.email], mail.to
    assert_equal "Rails recipes book reservation", mail.subject
    assert_match /"Free" at:.+\/books\/#{@book.id}/, mail.body.encoded
  end
  
end
