class PostsController < ApplicationController
  before_action :require_login, only: %i[new create]

  def index
    @posts = Post.order(created_at: :desc).limit(100)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "投稿が完了しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end
