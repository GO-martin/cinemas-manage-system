class Location < ApplicationRecord
  resourcify

  has_many :cinemas
  has_many :showtimes

  validates :name, presence: true, uniqueness: true

  scope :ordered, -> { order(id: :desc) }

  after_create_commit lambda {
                        broadcast_prepend_to 'admin', partial: 'admin/locations/location',
                                                      locals: { location: self }
                      }
  after_update_commit lambda {
                        broadcast_replace_to 'admin', partial: 'admin/locations/location'
                      }
  after_destroy_commit lambda {
                         broadcast_remove_to 'admin'
                       }

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end
end
