class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'pages_layout'

  def home
    @movies = Movie.ordered.limit(5)
  end

  def movie_detail
    @movie = Movie.find_by(id: params[:id])
  end

  def movies_now_showing
    @movies = Movie.now_showing.ordered
  end

  def movies_coming_soon
    @movies = Movie.coming_soon.ordered
  end

  def booking
    @movie = Movie.find_by(id: params[:id])
    @start_date = Date.today
    @end_date = @start_date + 15.days
    @selected_date = params[:selected_date] || @start_date
  end

  def get_showtimes
    selected_date = Date.parse(params[:selected_date])
    movie_id = params[:id]

    location_data = GetCollateralTabsDataService.call(selected_date, movie_id)
    respond_to do |format|
      format.json do
        render json: render_to_string(partial: 'pages/collateral_tabs', locals: { locations: location_data },
                                      formats: [:html])
      end
    end
  end

  def get_showtime; end

  def home_admin; end
end
