module Findable
  extend ActiveSupport::Concern

  included do
    before_action :set_resource, except: %i[index new create]
  end

  private

  def set_resource
    instance_variable_set("@#{resource_name}", resource_class.find_by(id: params[:id]))
  end

  def resource_name
    controller_name.singularize
  end

  def resource_class
    resource_name.capitalize.constantize
  end
end
