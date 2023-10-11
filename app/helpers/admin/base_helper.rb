module Admin::BaseHelper
  def active_tab(*controller)
    controller.include?(controller_name)
  end
end
