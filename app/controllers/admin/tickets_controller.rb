class Admin::TicketsController < Admin::BaseController
  def index
    @pagy, @tickets = pagy(Ticket.ordered)
  end

  def search
    search_term = params[:search_term]
    movie_filter = params[:movie_filter]
    room_filter = params[:room_filter]
    @pagy, @tickets = pagy(Ticket.by_filter(search_term, movie_filter, room_filter).ordered)

    respond_to do |format|
      format.json do
        render json: { tickets_html: render_to_string(partial: 'admin/tickets/ticket', collection: @tickets, layout: false, formats: [:html]),
                       pagination_html: render_to_string(PaginationComponent.new(pagy: @pagy), layout: false,
                                                                                               formats: [:html]) }
      end
      format.html { render :index }
    end
  end
end
