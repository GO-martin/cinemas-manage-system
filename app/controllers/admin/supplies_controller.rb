class Admin::SuppliesController < Admin::BaseController
  before_action :set_supply, only: %i[show edit update destroy destroy_modal]

  # GET admin/supplies or admin/supplies.json
  def index
    @pagy, @supplies = pagy(Supply.search(params[:term]))
  end

  # GET admin/supplies/1 or admin/supplies/1.json
  def show; end

  # GET admin/supplies/new
  def new
    @supply = Supply.new
  end

  # GET admin/supplies/1/edit
  def edit; end

  # POST admin/supplies or admin/supplies.json
  def create
    @supply = Supply.new(supply_params)

    respond_to do |format|
      if @supply.save
        format.turbo_stream do
          flash.now[:notice] = 'Supply was successfully created.'
          render turbo_stream: [
            turbo_stream.prepend('supplies', partial: 'admin/supplies/supply',
                                             locals: { supply: @supply }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_supplies_url, notice: 'Supply was successfully created.' }
        # format.json { render :show, status: :created, supply: @supply }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT admin/supplies/1 or admin/supplies/1.json
  def update
    respond_to do |format|
      if @supply.update(supply_params)
        format.turbo_stream do
          flash[:notice] = 'Supply was successfully updated.'
          render turbo_stream: [
            turbo_stream.replace(@supply, partial: 'admin/supplies/supply',
                                          locals: { supply: @supply }),
            render_flash_message
          ]
        end
        format.html { redirect_to admin_supplies_url, notice: 'Supply was successfully updated.' }
        # format.json { render :show, status: :ok, supply: @supply }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE admin/supplies/1 or admin/supplies/1.json
  def destroy
    @supply.destroy

    respond_to do |format|
      format.turbo_stream do
        flash[:notice] = 'Supply was successfully destroyed.'
        render turbo_stream: [
          turbo_stream.remove(@supply),
          render_flash_message
        ]
      end
      format.html { redirect_to admin_supplies_url, notice: 'Supply was successfully destroyed.' }
      # format.json { head :no_content }
    end
  end

  def destroy_modal; end

  private

  def set_supply
    @supply = Supply.find(params[:id])
  end

  def supply_params
    params.require(:supply).permit(:name, :quantity, :price, :cinema_id, :image)
  end
end
