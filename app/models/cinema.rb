class Cinema < ApplicationRecord
  resourcify

  belongs_to :location

  has_many :rooms, dependent: :destroy
  has_many :supplies, dependent: :destroy
  has_many :showtimes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :location_id, presence: true

  scope :ordered, -> { order(id: :desc) }

  after_create_commit do
    broadcast_prepend_to 'admin', partial: 'admin/cinemas/cinema',
                                  locals: { cinema: self }
  end

  after_update_commit do
    broadcast_replace_to 'admin', partial: 'admin/cinemas/cinema'
  end

  after_destroy_commit do
    broadcast_remove_to 'admin'
  end

  def self.by_filter(search_term, location_filter)
    left_outer_joins(:location)
      .where('LOWER(cinemas.name) LIKE ?', "%#{search_term&.downcase}%")
      .where(locations: { id: location_filter.presence || Location.ids })
  end
end
