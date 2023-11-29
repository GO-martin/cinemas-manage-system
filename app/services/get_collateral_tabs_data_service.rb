class GetCollateralTabsDataService < ApplicationService
  attr_reader :selected_date, :movie_id

  def initialize(selected_date, movie_id)
    @selected_date = selected_date
    @movie_id = movie_id
  end

  def call
    if @selected_date == Date.today
      start_time = Time.current
      end_time = Time.current.end_of_day
    else
      start_time = @selected_date.beginning_of_day
      end_time = @selected_date.end_of_day
    end

    locations = Location.includes(:cinemas).all
    location_data = []

    locations.each do |location|
      cinema_data = []
      cinemas = location.cinemas

      cinemas.each do |cinema|
        showtimes = Showtime.where(
          location_id: location.id,
          cinema_id: cinema.id,
          start_time: start_time..end_time,
          movie_id: @movie_id
        )

        cinema_data << { id: cinema.id, name: cinema.name, showtimes: } if showtimes.present?
      end

      location_data << { cinemas: cinema_data, id: location.id, name: location.name } if cinema_data.present?
    end
    location_data
  end
end
