require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "login with valid credentials" do
    post login_path, params: { email: users(:admin).email, password: "ChangeMeNow!123" }
    assert_redirected_to root_path
    assert_equal users(:admin).id, session[:user_id]
  end

  test "login with invalid credentials" do
    post login_path, params: { email: users(:admin).email, password: "wrong-password" }
    assert_response :unprocessable_entity
    assert_nil session[:user_id]
  end

  test "logout clears the session" do
    login_as users(:admin)
    delete logout_path
    assert_redirected_to root_path
    assert_nil session[:user_id]
  end
end
