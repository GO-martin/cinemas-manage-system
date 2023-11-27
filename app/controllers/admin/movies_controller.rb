class Admin::MoviesController < Admin::BaseController
  include Findable
  # GET admin/movies or admin/movies.json
  def index
    @pagy, @movies = pagy(Movie.ordered)
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
    if params.dig(:movie, :poster).present?
      @movie.delete_attachment
    end
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

  def change_now_showing
    @movie.now_showing!
    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = 'Movie was successfully changed status'
        render turbo_stream: [
          turbo_stream.replace(@movie, partial: 'admin/movies/movie', locals: { movie: @movie }),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_movies_url }
    end
  end

  def change_coming_soon
    @movie.coming_soon!
    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = 'Movie was successfully changed status'
        render turbo_stream: [
          turbo_stream.replace(@movie, partial: 'admin/movies/movie', locals: { movie: @movie }),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_movies_url }
    end
  end

  def search
    search_term = params[:search_term]
    status_filter = params[:status_filter]
    @pagy, @movies = pagy(Movie.by_filter(search_term, status_filter).ordered)

    respond_to do |format|
      format.json do
        render json: { movies_html: render_to_string(partial: 'admin/movies/movie', collection: @movies, layout: false, formats: [:html]),
                       pagination_html: render_to_string(PaginationComponent.new(pagy: @pagy), layout: false,
                                                                                               formats: [:html]) }
      end
      format.html { render :index }
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:poster, :banner, :trailer, :status, :director, :description, :release_date, :length,
                                  :name)
  end
end
