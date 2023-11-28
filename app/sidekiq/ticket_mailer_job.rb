class TicketMailerJob
  include Sidekiq::Job

  def perform(ticket_id)
    ticket = Ticket.find_by(id: ticket_id)
    TicketMailer.new_ticket_notification(ticket).deliver_now
  end
end
