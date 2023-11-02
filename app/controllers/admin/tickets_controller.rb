class Admin::TicketsController < Admin::BaseController
  def index
    @pagy, @tickets = pagy(Ticket.search(params[:term]))
  end
end
