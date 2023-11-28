class Admin::ProfilesController < Admin::BaseController
  before_action :set_profile, only: %i[edit update]

  def edit; end

  def update
    if params.dig(:profile, :avatar).present?
      @profile.delete_attachment
    end
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to edit_admin_profile_path(@profile), notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:avatar, :fullname, :birthday, :address, :user_id)
  end
end
