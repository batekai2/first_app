require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "index is publicly readable" do
    get posts_path
    assert_response :success
    assert_match "テスト投稿です", response.body
  end

  test "new requires login" do
    get new_post_path
    assert_redirected_to login_path
  end

  test "create requires login" do
    assert_no_difference("Post.count") do
      post posts_path, params: { post: { content: "未ログイン投稿" } }
    end
    assert_redirected_to login_path
  end

  test "logged in user can create a post" do
    login_as users(:admin)

    assert_difference("Post.count", 1) do
      post posts_path, params: { post: { content: "ログイン後の投稿" } }
    end

    assert_redirected_to posts_path
    follow_redirect!
    assert_match "ログイン後の投稿", response.body
  end

  test "rejects overly long content" do
    login_as users(:admin)

    assert_no_difference("Post.count") do
      post posts_path, params: { post: { content: "a" * 1001 } }
    end
    assert_response :unprocessable_entity
  end
end
