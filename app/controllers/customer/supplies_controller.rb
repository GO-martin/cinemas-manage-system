class Customer::SuppliesController < Customer::BaseController
  def index
    @supplies = Supply.all.ordered
  end

  def booking_supplies
    @supplies = Supply.where(cinema_id: params[:cinema_id]).quantity_more_than(0).ordered
  end
end
