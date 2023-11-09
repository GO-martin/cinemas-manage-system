class NotificationsController < ApplicationController
  def view_all
    @notifications = current_user.notifications
    @notifications.update(viewed: true)
  end
end
