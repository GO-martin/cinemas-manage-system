# frozen_string_literal: true

class TurboModalComponent < ViewComponent::Base
  include Turbo::FramesHelper
  def initialize(title:, titleType:)
    @title = title
    @titleType = titleType
  end

  def checkModal(*modalTitle, title)
    modalTitle.include?(title)
  end
end
