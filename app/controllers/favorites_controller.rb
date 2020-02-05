class FavoritesController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    user.like(post)
    redirect_to user
  end

  def destroy
    post = Favorite.find(params[:id]).favorites
    current_user.unlike(post)
    redirect_to user
  end
  
end
