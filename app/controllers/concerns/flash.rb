module Flash
  def render_flash_message
    turbo_stream.prepend('flash', partial: 'layouts/components/flash')
  end
end
