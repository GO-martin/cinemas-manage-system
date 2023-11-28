# frozen_string_literal: true

class TurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  def initialize(title:, title_type:)
    @title = title
    @title_type = title_type
  end

  def check_modal(*modal_title, title)
    modal_title.include?(title)
  end
end
