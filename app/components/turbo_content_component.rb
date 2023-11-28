# frozen_string_literal: true

class TurboContentComponent < ViewComponent::Base
  def initialize(title:, title_type:)
    @title = title
    @title_type = title_type
  end
end
