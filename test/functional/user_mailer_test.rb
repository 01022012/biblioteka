require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  
  setup do
    @user = Factory(:user)
  end
  
  should "deliver welcome email" do
    mail = UserMailer.welcome_email(@user)
    assert_equal [@user.email], mail.to
    assert_equal 'Welcome to Library', mail.subject
    assert_match /Sign in at:.+\/session\/new/, mail.body.encoded
  end
  
end
