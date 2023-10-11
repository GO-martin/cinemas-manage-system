# frozen_string_literal: true

class TurboContentComponent < ViewComponent::Base
  def initialize(title:, titleType:)
    @title = title
    @titleType = titleType
  end
end
