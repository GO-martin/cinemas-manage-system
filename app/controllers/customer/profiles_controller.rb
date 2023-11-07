class Customer::ProfilesController < Customer::BaseController
  before_action :set_profile, only: %i[edit update]
  before_action :check_admin_login

  def edit; end

  def update
    # respond_to do |format|
    if @profile.update(profile_params)
      # format.html { redirect_to root_path }
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
    # end
  end

  private

  def check_admin_login
    return unless current_user.has_role?(:admin)

    redirect_to root_path
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:fullname, :birthday, :address, :user_id)
  end
end
