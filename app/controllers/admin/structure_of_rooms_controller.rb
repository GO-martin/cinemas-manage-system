class Admin::StructureOfRoomsController < Admin::BaseController
  before_action :set_structure_of_room, only: %i[update]

  def create
    @structure_of_room = StructureOfRoom.new(structure_of_room_params)
    respond_to do |format|
      if @structure_of_room.save
        format.html { redirect_to admin_rooms_path, notice: 'Structure Of Room was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @structure_of_room.update(structure_of_room_params)
        # format.html { redirect_to admin_rooms_url, notice: 'Structure Of Room was successfully updated.' }

      else
        format.html { render :edit, status: :unprocessable_entity }
      end
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
