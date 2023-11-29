class Admin::DashboardsController < Admin::BaseController
  def index
    @main_chart_data = GetMainChartDataService.call(7)
    @location_chart_data = GetLocationChartDataService.call(7)
    @top_movies = Movie.get_top_movies(5, 7)
    @top_customers = User.get_top_customers(5, 7)
    @new_customers_chart_data = GetNewCustomersChartDataService.call(30)
    @new_tickets_chart_data = GetNewTicketsChartDataService.call(30)
  end

  def update_main_chart
    @main_chart_data = GetMainChartDataService.call(params[:period].to_i)
    respond_to do |format|
      format.json do
        render json: { main_chart_data: @main_chart_data }
      end
    end
  end

  def update_stats
    @top_movies = Movie.get_top_movies(5, params[:period].to_i)
    @top_customers = User.get_top_customers(5, params[:period].to_i)

    respond_to do |format|
      format.json do
        render json: { top_movies_html: render_to_string(partial: 'admin/dashboards/top_movies',
                                                         locals: { top_movies: @top_movies }, layout: false, formats: [:html]),
                       top_customers_html: render_to_string(partial: 'admin/dashboards/top_customers',
                                                            locals: { top_customers: @top_customers }, layout: false, formats: [:html]) }
      end
    end
  end

  def update_location_chart
    @location_chart_data = GetLocationChartDataService.call(params[:period].to_i)
    respond_to do |format|
      format.json do
        render json: { location_chart_data: @location_chart_data }
      end
    end
  end
end
