class Profile < ApplicationRecord
  resourcify

  belongs_to :user
end
