class Customer::RoomsController < Customer::BaseController
  include Findable
  def show
    @structures = @room.structure_of_rooms
    @sold_tickets = Ticket.where(showtime_id: params[:showtime_id])
    respond_to do |format|
      format.json do
        render json: render_to_string(partial: 'customer/rooms/room',
                                      locals: { structures: @structures, sold_tickets: @sold_tickets, room: @room },
                                      formats: [:html])
      end
    end
  end
end
