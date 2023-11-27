class Admin::StructureOfRoomsController < Admin::BaseController
  before_action :set_structure_of_room, only: %i[update]

  def create
    @structure_of_room = StructureOfRoom.new(structure_of_room_params)
    if @structure_of_room.save
      respond_to do |format|
        format.html { redirect_to admin_rooms_path, notice: 'Structure Of Room was successfully created.' }
      end
    else
      head :unprocessable_entity
    end
  end

  def update
    if @structure_of_room.update(structure_of_room_params)
      respond_to do |format|
        format.html { redirect_to admin_rooms_path, notice: 'Structure Of Room was successfully updated.' }
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def set_structure_of_room
    @structure_of_room = StructureOfRoom.find(params[:id])
  end

  def structure_of_room_params
    params.require(:structure_of_room).permit(:row_index, :column_index, :type_seat, :room_id)
  end
end
