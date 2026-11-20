class SessionsController < ApplicationController
  rate_limit to: 10, within: 1.minute, only: :create, with: -> {
    redirect_to login_path, alert: "ログイン試行が多すぎます。しばらく待ってから再度お試しください。"
  }

  def new
  end

  def create
    user = User.find_by(email: params[:email].to_s.downcase.strip)

    if user&.authenticate(params[:password])
      reset_session
      session[:user_id] = user.id
      redirect_to root_path, notice: "ログインしました。"
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません。"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: "ログアウトしました。"
  end
end
