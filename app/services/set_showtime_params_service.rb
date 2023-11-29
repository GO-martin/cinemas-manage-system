class SetShowtimeParamsService < ApplicationService
  attr_accessor :params

  def initialize(params)
    @params = params
  end

  def call
    @params[:duration] = Movie.find_by(id: @params[:movie_id]).length
    parsed_start_time = Time.parse(@params[:start_time])
    @params[:end_time] = parsed_start_time + @params[:duration].minutes
    @params[:cinema_id] = Room.find_by(id: @params[:room_id]).cinema.id
    @params[:location_id] = Room.find_by(id: @params[:room_id]).cinema.location.id
    @params
  end
end
