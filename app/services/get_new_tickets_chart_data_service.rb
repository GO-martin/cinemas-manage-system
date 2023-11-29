class GetNewTicketsChartDataService < ApplicationService
  attr_reader :period

  def initialize(period)
    @period = period
  end

  def call
    new_tickets_chart_data = {}

    current_data = Ticket.tickets_chart_data(@period)
    total_new_tickets = Ticket.total_new_tickets(@period)
    new_tickets_chart_data[:current_data] = current_data
    new_tickets_chart_data[:total_new_tickets] = total_new_tickets

    new_tickets_chart_data
  end
end
