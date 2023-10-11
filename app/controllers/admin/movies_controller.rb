class Admin::MoviesController < Admin::BaseController
  before_action :set_movie, only: %i[show edit update destroy destroy_modal]

  # GET admin/movies or admin/movies.json
  def index
    @pagy, @movies = pagy(Movie.search(params[:term]))
  end

  # GET admin/movies/1 or admin/movies/1.json
  def show; end

  # GET admin/movies/new
  def new
    @movie = Movie.new
  end

  # GET admin/movies/1/edit
  def edit; end

  # POST admin/movies or admin/movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to admin_movies_path, notice: 'Movie was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/movies/1 or admin/movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to admin_movies_url, notice: 'Movie was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/movies/1 or admin/movies/1.json
  def destroy
    @movie.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:notice] = 'Movie was successfully destroyed.'
        render turbo_stream: [
          turbo_stream.remove(@movie),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_movies_url, notice: 'Movie was successfully destroyed.' }
    end
  end

  def destroy_modal; end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:poster, :trailer, :director, :description, :release_date)
  end
end
