module DeletableAttachment
  extend ActiveSupport::Concern

  def delete_attachment
    if respond_to?(attachment_name) && send(attachment_name).attached?
      send(attachment_name).purge
    end
  end
end
