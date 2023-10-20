class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'page_layout'

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

  def dashboard; end

  def home_admin; end
end
