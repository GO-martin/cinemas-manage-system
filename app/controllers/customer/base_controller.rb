class Customer::BaseController < ApplicationController
  layout 'pages_layout'
  before_action :authenticate_user!
end
