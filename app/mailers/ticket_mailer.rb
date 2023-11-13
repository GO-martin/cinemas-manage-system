class TicketMailer < ApplicationMailer
  def new_ticket_notification(ticket)
    @ticket = ticket
    mail(to: @ticket.user.email, subject: 'Thank You for choosing us')
  end
end
