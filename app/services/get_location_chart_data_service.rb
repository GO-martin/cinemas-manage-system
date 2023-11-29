class GetLocationChartDataService < ApplicationService
  attr_reader :period

  def initialize(period)
    @period = period
  end

  def call
    location_chart_data = {}

    current_location_chart_data = Location.locations_chart_data(@period)
    location_chart_data[:current_location_chart_data] = current_location_chart_data
    location_chart_data
  end
end
