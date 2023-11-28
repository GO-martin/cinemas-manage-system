class Customer::ProfilesController < Customer::BaseController
  before_action :check_admin_login
  include Findable
  def edit; end

  def update
    if params.dig(:profile, :avatar).present?
      @profile.delete_attachment
    end
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to edit_customer_profile_path(@profile), notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def check_admin_login
    return unless current_user.has_role?(:admin)

    redirect_to root_path
  end

  def profile_params
    params.require(:profile).permit(:avatar, :fullname, :birthday, :address, :user_id)
  end
end
