class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout "page_layout"

  def home
  end

  def dashboard
  end

  def home_admin
  end
end
