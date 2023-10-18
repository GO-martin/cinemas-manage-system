class Admin::CinemasController < Admin::BaseController
  before_action :set_cinema, only: %i[show edit update destroy destroy_modal]

  # GET admin/cinemas or admin/cinemas.json
  def index
    @pagy, @cinemas = pagy(Cinema.search(params[:term]))
  end

  # GET admin/cinemas/1 or admin/cinemas/1.json
  def show; end

  # GET admin/cinemas/new
  def new
    @cinema = Cinema.new
  end

  # GET admin/cinemas/1/edit
  def edit; end

  # POST admin/cinemas or admin/cinemas.json
  def create
    @cinema = Cinema.new(cinema_params)

    respond_to do |format|
      if @cinema.save
        format.turbo_stream do
          flash.now[:notice] = 'Cinema was successfully created.'
          render turbo_stream: [
            turbo_stream.prepend('cinemas', partial: 'admin/cinemas/cinema',
                                            locals: { cinema: @cinema }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_cinemas_url, notice: 'Cinema was successfully created.' }
        # format.json { render :show, status: :created, cinema: @cinema }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @cinema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/cinemas/1 or admin/cinemas/1.json
  def update
    respond_to do |format|
      if @cinema.update(cinema_params)
        format.turbo_stream do
          flash[:notice] = 'Cinema was successfully updated.'
          render turbo_stream: [
            turbo_stream.replace(@cinema, partial: 'admin/cinemas/cinema',
                                          locals: { cinema: @cinema }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_cinemas_url, notice: 'Cinema was successfully updated.' }
        # format.json { render :show, status: :ok, cinema: @cinema }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cinema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/cinemas/1 or admin/cinemas/1.json
  def destroy
    @cinema.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:notice] = 'Cinema was successfully destroyed.'
        render turbo_stream: [
          turbo_stream.remove(@cinema),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_cinemas_url, notice: 'Cinema was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  def destroy_modal; end

  private

  def set_cinema
    @cinema = Cinema.find(params[:id])
  end

  def cinema_params
    params.require(:cinema).permit(:name, :description, :location_id)
  end
end
