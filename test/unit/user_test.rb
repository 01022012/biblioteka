require 'test_helper'

class UserTest < ActiveSupport::TestCase

  context "user instance" do
    
    subject { Factory(:user) }
    
    should validate_presence_of   :email
    should validate_uniqueness_of :email
    
  end
  
  context "serializing" do

    setup do
      @user = Factory(:user, email: 'info@eficode.fi', password_digest: 'aabbcc')
    end

    should "serialize email" do
      assert_match /info@eficode.fi/, @user.to_json
    end

    should "not serialize password digest" do
      assert_no_match /aabbcc/, @user.to_json
    end

  end

end
