class Customer::TicketsController < Customer::BaseController
  def index
    @tickets = Ticket.where(user_id: current_user.id).order(id: :desc)
  end

  def new; end

  def create
    @ticket = Ticket.new(ticket_params)
    respond_to do |format|
      if @ticket.save
        TicketMailerJob.perform_async(@ticket.id)
        format.json { render json: { ticket_id: @ticket.id } }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:seat_row, :seat_column, :price, :user_id, :showtime_id, :stripe_payment_id,
                                   :seat_name)
  end
end
