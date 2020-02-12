class NotificationsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  def index
    @user = current_user
    @notifications = current_user.passive_notifications.paginate(page: params[:page])
  end
end


