require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "requires content" do
    post = Post.new(user: users(:admin), content: "")
    assert_not post.valid?
    assert_includes post.errors[:content], "can't be blank"
  end

  test "limits content length" do
    post = Post.new(user: users(:admin), content: "a" * 1001)
    assert_not post.valid?
  end
end
