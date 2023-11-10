class Customer::RoomsController < Customer::BaseController
  before_action :set_room, only: %i[show]

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

  private

  def set_room
    @room = Room.find(params[:id])
  end
end
