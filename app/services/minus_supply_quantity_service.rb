class MinusSupplyQuantityService < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    id = @params[:ticket_supply][:supply_id]
    quantity = @params[:ticket_supply][:quantity]
    supply = Supply.find_by(id:)

    raise StandardError, 'Error: Quantity' unless supply.quantity >= quantity

    supply.update!(quantity: supply.quantity -= quantity)
  end
end
