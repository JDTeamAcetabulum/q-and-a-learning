require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  test "login with invalid information" do
    get login_path
    assert_template 'login/login'
    post login_path, params: { login: { email: "", password: "" } }
    assert_template 'login/login'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
