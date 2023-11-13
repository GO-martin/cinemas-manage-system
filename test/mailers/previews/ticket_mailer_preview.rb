# Preview all emails at http://localhost:3000/rails/mailers/ticket_mailer
class TicketMailerPreview < ActionMailer::Preview
  def new_ticket_notification
    ticket = Ticket.new(price: 900)
    TicketMailer.new_ticket_notification(ticket)
  end
end
