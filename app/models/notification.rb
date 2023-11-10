class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :user

  scope :unviewed, -> { where(viewed: false) }
  default_scope { latest }

  after_create_commit do
    broadcast_prepend_to "broadcast_to_user_#{user_id}",
                         target: :notifications,
                         partial: 'admin/notifications/notification'
    broadcast_prepend_to "broadcast_to_user_#{user_id}",
                         target: 'notifications_navbar',
                         partial: 'notifications/navbar',
                         locals: { notifications: user.unviewed_notifications }
  end

  after_update_commit do
    broadcast_replace_to "broadcast_to_user_#{user_id}",
                         partial: 'admin/notifications/notification'
    broadcast_replace_to "broadcast_to_user_#{user_id}",
                         target: 'notifications_navbar',
                         partial: 'notifications/navbar',
                         locals: { notifications: user.unviewed_notifications }
  end

  after_commit do
    broadcast_replace_to "broadcast_to_user_#{user_id}",
                         target: 'notifications_count',
                         partial: 'notifications/count',
                         locals: { count: user.unviewed_notifications_count }
  end
end
