class PostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @user = Post.find(params[:id]).user
    @post = @user.posts.find(params[:id])
    @comments = @post.comments.paginate(page: params[:page])
    @comment = current_user.comments.build
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿が完了しました！"
      redirect_to @post
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "投稿を削除しました。"
    redirect_to request.referrer || root_url
  end


  def explore
    #Viewのformで取得したパラメータをモデルに渡す
    @posts = Post.explore(params[:explore])
  end

  private

    def post_params
      params.require(:post).permit(:picture, :text)
    end

    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end
