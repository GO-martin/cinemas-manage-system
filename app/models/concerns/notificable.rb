module Notificable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :notifiable, dependent: :destroy
    after_create_commit do
      send_notifications_to_users
      send_jobs
    end
  end

  def send_notifications_to_users
    Notification.create(user_id:, user_role: 1, notifiable: self)
    return unless respond_to? :user_ids

    user_ids&.each do |user_id|
      Notification.create user_id:, notifiable: self
    end
  end

  def send_jobs
    TicketMailerJob.perform_async(id)
    if (showtime.start_time - Time.current) < 30.minutes
      TicketNotificationJob.perform_async(id)
    else
      TicketNotificationJob.perform_at(showtime.start_time - 30.minutes, id)
    end
  end
end
