class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @post = Post.find(params[:post_id])
    unless current_user.like?(@post)
      current_user.like(@post)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  end

  def destroy
    @post = Favorite.find(params[:id]).post
    if current_user.like?(@post)
      current_user.unlike(@post)
      respond_to do |format|
        format.html { redirect_back(fallback_location: root_path) }
        format.js
      end
    end
  end
end