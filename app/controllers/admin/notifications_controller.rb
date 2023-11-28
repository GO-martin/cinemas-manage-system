class Admin::NotificationsController < Admin::BaseController
  def index
    @pagy, @notifications = pagy(current_user.notifications)
    @notifications.update(viewed: true)
  end
end
