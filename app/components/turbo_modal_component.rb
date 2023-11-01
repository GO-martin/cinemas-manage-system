# frozen_string_literal: true

class TurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  def initialize(title:, titleType:)
    @title = title
    @titleType = titleType
  end

  def check_modal(*modal_title, title)
    modal_title.include?(title)
  end
end
