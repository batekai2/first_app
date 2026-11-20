require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "requires a sufficiently long password" do
    user = User.new(email: "new@example.com", password: "short")
    assert_not user.valid?
  end

  test "normalizes email" do
    user = User.create!(email: "  New@Example.COM ", password: "ChangeMeNow!123")
    assert_equal "new@example.com", user.email
  end
end
