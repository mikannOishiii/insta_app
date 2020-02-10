class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  # before_action :correct_user,   only: :destroy

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.comments.all
    @comment = @post.comments.build
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params) 
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "comment created!"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    # Comment.find_by(post_id: params[:post_id]).destroy
    @comment = Comment.find_by(post_id: params[:post_id], id:params[:id])
    @comment.destroy
    flash[:success] = "Micropost deleted"
    redirect_back(fallback_location: root_path)
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    # def correct_user
    #   @comment = current_user.comments.find_by(id: params[:id])
    #   redirect_to root_url if @comment.nil?
    # end

end
