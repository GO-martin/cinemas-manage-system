class ApplicationController < ActionController::Base
  include Pundit::Authorization

  include Pagy::Backend
  # Cross-Site Request Forgery (CSRF)
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  private

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
