class StaticPagesController < ApplicationController
  def home
    if logged_in?
      # @post  = current_user.posts.build #投稿画面別途
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def terms
  end
end
