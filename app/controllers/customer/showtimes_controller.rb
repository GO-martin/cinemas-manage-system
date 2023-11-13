class Customer::ShowtimesController < Customer::BaseController
  before_action :set_showtime, only: %i[show]

  def show; end

  private

  def set_showtime
    @showtime = Showtime.find(params[:id])
  end
end
