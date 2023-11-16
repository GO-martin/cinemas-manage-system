class Admin::RoomsController < Admin::BaseController
  include Findable
  # GET admin/rooms or admin/rooms.json
  def index
    @pagy, @rooms = pagy(Room.ordered)
  end

  # GET admin/rooms/1 or admin/rooms/1.json
  def show; end

  # GET admin/rooms/new
  def new
    @room = Room.new
    # debugger
  end

  # GET admin/rooms/1/edit
  def edit; end

  # POST admin/rooms or admin/rooms.json
  def create
    # debugger
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.json { render json: { room_id: @room.id } }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/rooms/1 or admin/rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.json { render json: { room_id: @room.id } }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/rooms/1 or admin/rooms/1.json
  def destroy
    @room.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:notice] = 'Room was successfully destroyed.'
        render turbo_stream: [
          turbo_stream.remove(@room),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_rooms_url, notice: 'Room was successfully destroyed.' }
    end
  end

  def destroy_modal; end

  def search
    search_term = params[:searchTerm]
    cinema_filter = params[:cinemaFilter]
    @pagy, @rooms = pagy(Room.by_filter(search_term, cinema_filter).ordered)

    respond_to do |format|
      format.json do
        render json: { rooms_html: render_to_string(partial: 'admin/rooms/room', collection: @rooms, layout: false, formats: [:html]),
                       pagination_html: render_to_string(PaginationComponent.new(pagy: @pagy), layout: false,
                                                                                               formats: [:html]) }
      end
      format.html { render :index }
    end
  end

  private

  def room_params
    params.require(:room).permit(:name, :number_of_seats, :cinema_id, :row_size, :column_size)
  end
end
