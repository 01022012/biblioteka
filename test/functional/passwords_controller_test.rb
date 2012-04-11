require 'test_helper'

class PasswordsControllerTest < ActionController::TestCase
  should "get new" do
    get :new
    assert_response :success
  end

  should "get update" do
    get :update
    assert_response :success
  end

end
