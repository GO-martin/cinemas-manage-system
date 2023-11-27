class Admin::ShowtimesController < Admin::BaseController
  include Findable
  # GET admin/showtimes or admin/showtimes.json
  def index
    @pagy, @showtimes = pagy(Showtime.ordered)
  end

  # GET admin/showtimes/1 or admin/showtimes/1.json
  def show; end

  # GET admin/showtimes/new
  def new
    @showtime = Showtime.new
  end

  # GET admin/showtimes/1/edit
  def edit; end

  # POST admin/showtimes or admin/showtimes.json
  def create
    data = SetShowtimeParamsService.call(showtime_params)
    @showtime = Showtime.new(data)

    respond_to do |format|
      if @showtime.save
        format.turbo_stream do
          flash.now[:notice] = 'Showtime was successfully created.'
          render turbo_stream: [
            turbo_stream.prepend('showtimes', partial: 'admin/showtimes/showtime',
                                              locals: { showtime: @showtime }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_showtimes_url, notice: 'Showtime was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @showtime.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/showtimes/1 or admin/showtimes/1.json
  def update
    data = SetShowtimeParamsService.call(showtime_params)
    respond_to do |format|
      if @showtime.update(data)
        format.turbo_stream do
          flash[:notice] = 'Showtime was successfully updated.'
          render turbo_stream: [
            turbo_stream.replace(@showtime, partial: 'admin/showtimes/showtime',
                                            locals: { showtime: @showtime }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_showtimes_url, notice: 'Showtime was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @showtime.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/showtimes/1 or admin/showtimes/1.json
  def destroy
    @showtime.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:notice] = 'Showtime was successfully destroyed.'
        render turbo_stream: [
          turbo_stream.remove(@showtime),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_showtimes_url, notice: 'Showtime was successfully destroyed.' }
    end
  end

  def destroy_modal; end

  def search
    search_term = params[:search_term]
    room_filter = params[:room_filter]
    movie_filter = params[:movie_filter]

    @pagy, @showtimes = pagy(Showtime.by_filter(search_term, room_filter, movie_filter).ordered)

    respond_to do |format|
      format.json do
        render json: { showtimes_html: render_to_string(partial: 'admin/showtimes/showtime', collection: @showtimes, layout: false, formats: [:html]),
                       pagination_html: render_to_string(PaginationComponent.new(pagy: @pagy), layout: false,
                                                                                               formats: [:html]) }
      end
      format.html { render :index }
    end
  end

  private

  def showtime_params
    params.require(:showtime).permit(:room_id, :movie_id, :location_id, :cinema_id, :start_time, :fare, :duration,
                                     :end_time)
  end
end
