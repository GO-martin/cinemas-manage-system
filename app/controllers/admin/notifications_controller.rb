class Admin::NotificationsController < Admin::BaseController
  def index
    @pagy, @notifications = pagy(Notification.all)
    @notifications.update(viewed: true)
  end
end
