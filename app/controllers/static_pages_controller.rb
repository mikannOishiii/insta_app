class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # @post  = current_user.posts.build #投稿画面別途
      # @feed_items = current_user.feed.paginate(page: params[:page])
      
      following_ids = "SELECT followed_id FROM relationships
                      WHERE follower_id = :user_id"
      posts = Post.where("user_id IN (#{following_ids})
                      OR user_id = :user_id", user_id: current_user.id)
      @feed_items = posts.paginate(page: params[:page])
    end
  end

  def terms
  end
end
