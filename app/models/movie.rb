class Movie < ApplicationRecord
  resourcify

  has_many :showtimes, dependent: :destroy

  enum :status, { now_showing: 0, coming_soon: 1 }

  validates :poster, :director, :name, :length, :release_date, :trailer, :description, presence: true

  scope :ordered, -> { order(id: :desc) }

  has_one_attached :poster, dependent: :destroy
  has_one_attached :banner, dependent: :destroy

  after_create_commit do
    broadcast_prepend_to 'admin', partial: 'admin/movies/movie',
                                  locals: { movie: self }
  end

  after_update_commit do
    broadcast_replace_to 'admin', partial: 'admin/movies/movie'
  end

  after_destroy_commit do
    broadcast_remove_to 'admin'
  end

  def self.by_filter(search_term, status_filter)
    where('LOWER(movies.name) LIKE ?', "%#{search_term.downcase}%")
      .where(status: status_filter.presence || Movie.distinct.pluck(:status))
  end
end
