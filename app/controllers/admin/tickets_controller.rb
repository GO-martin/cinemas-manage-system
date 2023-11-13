class Admin::TicketsController < Admin::BaseController
  def index
    @pagy, @tickets = pagy(Ticket.ordered)
  end

  def search
    search_term = params[:searchTerm]
    movie_filter = params[:movieFilter]
    room_filter = params[:roomFilter]
    @pagy, @tickets = pagy(Ticket.by_filter(search_term, movie_filter, room_filter).ordered)

    respond_to do |format|
      format.json do
        render json: { tickets_html: render_to_string(partial: 'admin/tickets/ticket', collection: @tickets, layout: false, formats: [:html]),
                       pagination_html: render_to_string(PaginationComponent.new(pagy: @pagy), layout: false,
                                                                                               formats: [:html]) }
      end
    end
  end
end
