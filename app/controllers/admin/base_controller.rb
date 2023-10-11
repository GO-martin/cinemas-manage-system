class Admin::BaseController < ApplicationController
  layout 'admin_layout'
  include Flash

  before_action :authenticate_admin

  private

  def authenticate_admin
    redirect_to '/500', alert: 'Not authorized.' unless current_user.has_role?(:admin)
  end
end
