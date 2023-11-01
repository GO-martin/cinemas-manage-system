class Customer::TicketSuppliesController < Customer::BaseController
  def create
    @ticket_supply = TicketSupply.new(ticket_supply_params)
    respond_to do |format|
      if @ticket_supply.save
        format.html { redirect_to root_path }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def ticket_supply_params
    params.require(:ticket_supply).permit(:ticket_id, :supply_id, :quantity)
  end
end
