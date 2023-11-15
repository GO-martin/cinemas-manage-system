class TicketNotificationJob
  include Sidekiq::Job

  def perform(ticket_id)
    ticket = Ticket.find(ticket_id)
    Notification.create(user_id: ticket.user_id, user_role: 1, notifiable: ticket, schedule: 1)
  end
end
