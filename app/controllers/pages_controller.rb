class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'pages_layout'

  def home
    @movies = Movie.limit(7)
  end

  def movie_detail
    @movie = Movie.find(params[:id])
  end

  def movies_now_showing
    @movies = Movie.now_showing.ordered
  end

  def movies_coming_soon
    @movies = Movie.coming_soon.ordered
  end

  def booking
    @movie = Movie.find(params[:id])
    @start_date = Date.today
    @end_date = @start_date + 15.days
    @selected_date = params[:selected_date] || @start_date
  end

  def get_showtimes
    selected_date = Date.parse(params[:selected_date])

    locations = Location.all
    location_data = []

    locations.each do |location|
      cinema_data = []
      cinemas = location.cinemas

      cinemas.each do |cinema|
        showtimes = Showtime.where(
          location_id: location.id,
          cinema_id: cinema.id,
          start_time: selected_date.beginning_of_day..selected_date.end_of_day,
          movie_id: params[:id]
        )

        cinema_data << { id: cinema.id, name: cinema.name, showtimes: } if showtimes.present?
      end

      location_data << { cinemas: cinema_data, id: location.id, name: location.name } if cinema_data.present?
    end

    p location_data

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
