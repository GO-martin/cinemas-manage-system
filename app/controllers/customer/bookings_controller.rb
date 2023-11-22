class Customer::BookingsController < ApplicationController
  def create
    @booking = Booking.new(booking_params)

    respond_to do |format|
      if @booking.save
        format.json { render json: { id: @booking.id } }
      else
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @booking = Booking.find_by(id: params[:id])
    @booking.destroy
    format.json { head :no_content }
  end

  private

  def booking_params
    params.require(:booking).permit(:showtime_id, :row_index, :column_index, :user_id)
  end
end
