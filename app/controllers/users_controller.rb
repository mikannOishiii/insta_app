class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy, :fav_lists]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    # @post = Post.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "会員登録が完了しました!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(profile_params)
      flash[:success] = "プロフィールを更新しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "アカウントを削除しました。"
    redirect_to root_url
  end

  def password_change
    @user = current_user
  end

  def password_update
    @user = current_user
    if params[:user][:password].empty? or params[:user][:old_password].empty?
      @user.errors.add(:password, :blank)
      render 'password_change'
    # 入力した旧PWがDBに保存されているパスワードと一致し、
    # 新PWと確認PWに同じ値が入っていれば、更新する
    elsif @user.authenticate(params[:user][:old_password]) && @user.update_attributes(password_params)
      flash[:success] = "パスワードを変更しました。"
      redirect_to @user
    else
      render 'password_change'
    end
  end

  def fav_lists
    @user  = User.find(params[:id])
    @posts = @user.fav_lists.paginate(page: params[:page])
    # @post = @posts.find_by(params[:id])
    render 'show_fav_lists'
  end

  private

    def user_params
      params.require(:user).permit(:name, :user_name, :password,
                                   :password_confirmation)
    end

    def profile_params
      params.require(:user).permit(:name, :user_name, :website, :pr_text,
                                   :email, :phone, :gender)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    # beforeアクション

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
