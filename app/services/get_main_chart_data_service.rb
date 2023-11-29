class GetMainChartDataService < ApplicationService
  def initialize(period)
    @period = period
  end

  def call
    main_chart_data = {}

    current_main_chart_data = Ticket.main_chart_data(@period)

    total_revenue = Ticket.total_revenue(@period)
    main_chart_data[:current_main_chart_data] = current_main_chart_data
    main_chart_data[:total_revenue] = total_revenue

    main_chart_data
  end
end
