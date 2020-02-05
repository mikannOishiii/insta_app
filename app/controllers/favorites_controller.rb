class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:post_id])
    @user.like(@post)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @post = Favorite.find(params[:id]).favorites
    current_user.unlike(@post)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
end
