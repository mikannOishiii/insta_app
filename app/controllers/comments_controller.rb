class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    @add_comment = current_user.comments.build
  end

  def create
    @add_comment = current_user.comments.build(comment_params)
    if @add_comment.save
      flash[:success] = "comment created!"
      redirect_to 'comments/index'
    else
      render 'comments/index'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = "Micropost deleted"
    redirect_to redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def correct_user
      @comment = current_user.comment.find_by(id: params[:id])
      redirect_to root_url if @comment.nil?
    end

end
