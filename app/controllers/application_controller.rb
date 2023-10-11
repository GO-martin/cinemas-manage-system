class ApplicationController < ActionController::Base
  include Pundit::Authorization

  include Pagy::Backend
  # Cross-Site Request Forgery (CSRF)
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    direct_by_role(resource)
  end

  def direct_by_role(resource)
    if resource.has_role? :admin
      admin_locations_path
    else
      root_path
    end
  end
end
