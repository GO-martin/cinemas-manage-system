class Admin::LocationsController < Admin::BaseController
  include Findable
  # GET admin/locations or admin/locations.json
  def index
    @pagy, @locations = pagy(Location.ordered)
  end

  # GET admin/locations/1 or admin/locations/1.json
  def show; end

  # GET admin/locations/new
  def new
    @location = Location.new
  end

  # GET admin/locations/1/edit
  def edit; end

  # POST admin/locations or admin/locations.json
  def create
    @location = Location.new(location_params)

    respond_to do |format|
      if @location.save
        format.turbo_stream do
          flash.now[:notice] = 'Location was successfully created.'
          render turbo_stream: [
            turbo_stream.prepend('locations', partial: 'admin/locations/location',
                                              locals: { location: @location }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_locations_url, notice: 'Location was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/locations/1 or admin/locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.turbo_stream do
          flash.now[:notice] = 'Location was successfully updated.'
          render turbo_stream: [
            turbo_stream.replace(@location, partial: 'admin/locations/location',
                                            locals: { location: @location }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_locations_url, notice: 'Location was successfully updated.' }
        # format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/locations/1 or admin/locations/1.json
  def destroy
    @location.destroy

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = 'Location was successfully destroyed.'
        render turbo_stream: [
          turbo_stream.remove(@location),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_locations_url, notice: 'Location was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  def destroy_modal; end

  def search
    search_term = params[:search_term]

    @pagy, @locations = pagy(Location.by_filter(search_term).ordered)

    respond_to do |format|
      format.json do
        render json: { locations_html: render_to_string(partial: 'admin/locations/location', collection: @locations, layout: false, formats: [:html]),
                       pagination_html: render_to_string(PaginationComponent.new(pagy: @pagy), layout: false,
                                                                                               formats: [:html]) }
      end
      format.html { render :index }
    end
  end

  private

  def location_params
    params.require(:location).permit(:name)
  end
end
