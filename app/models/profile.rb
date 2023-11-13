class Profile < ApplicationRecord
  resourcify

  belongs_to :user

  has_one_attached :avatar, dependent: :destroy
end
