class GetNewCustomersChartDataService < ApplicationService
  def initialize(period)
    @period = period
  end

  def call
    new_customers_chart_data = {}

    current_data = User.customers_chart_data(@period)
    total_new_users = User.total_new_users(@period)
    new_customers_chart_data[:current_data] = current_data
    new_customers_chart_data[:total_new_users] = total_new_users

    new_customers_chart_data
  end
end
