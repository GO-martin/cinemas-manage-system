class Admin::UsersController < Admin::BaseController
  # GET admin/users or admin/users.json
  def index
    @pagy, @users = pagy(User.search(params[:term]))
  end
end
