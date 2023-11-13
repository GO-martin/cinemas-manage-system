class Admin::ProfilesController < Admin::BaseController
  before_action :set_profile, only: %i[edit update]

  def edit; end

  def update
    if @profile.update(profile_params)
      # format.html { redirect_to root_path }
    else
      format.html { render :edit, status: :unprocessable_entity }
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:fullname, :birthday, :address, :user_id)
  end
end
