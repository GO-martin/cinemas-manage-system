class Profile < ApplicationRecord
  resourcify
  include DeletableAttachment

  belongs_to :user

  has_one_attached :avatar, dependent: :destroy

  validates :fullname, presence: true

  def attachment_name
    :avatar
  end
end
