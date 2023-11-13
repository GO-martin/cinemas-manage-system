class TicketMailerJob
  include Sidekiq::Job

  def perform(ticket_id)
    ticket = Ticket.find(ticket_id)
    TicketMailer.new_ticket_notification(ticket).deliver_now
  end
end
