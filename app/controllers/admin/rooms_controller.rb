class Admin::RoomsController < Admin::BaseController
  before_action :set_room, only: %i[show edit update destroy destroy_modal]

  # GET admin/rooms or admin/rooms.json
  def index
    @pagy, @rooms = pagy(Room.search(params[:term]))
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

  private

  def set_room
    @room = Room.find(params[:id])
  end

  def room_params
    params.require(:room).permit(:name, :number_of_seats, :cinema_id)
  end
end
