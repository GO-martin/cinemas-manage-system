class Admin::UsersController < Admin::BaseController
  # GET admin/users or admin/users.json
  def index
    @pagy, @users = pagy(User.ordered)
  end

  def search
    search_term = params[:searchTerm]
    @pagy, @users = pagy(User.by_filter(search_term).ordered)

    respond_to do |format|
      format.json do
        render json: { users_html: render_to_string(partial: 'admin/users/user', collection: @users, layout: false, formats: [:html]),
                       pagination_html: render_to_string(PaginationComponent.new(pagy: @pagy), layout: false,
                                                                                               formats: [:html]) }
      end
      format.html { render :index }
    end
  end
end
