class Customer::BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.json { render json: { id: @booking.id } }
        format.html { head :ok }
      else
        format.json { render json: @booking.errors, status: :unprocessable_entity }
        format.html { head :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking = Booking.find_by(id: params[:id])
    @booking.destroy
    respond_to do |format|
      format.html { head :ok }
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:showtime_id, :row_index, :column_index, :user_id)
  end
end
