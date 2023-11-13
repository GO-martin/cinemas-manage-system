class Showtime < ApplicationRecord
  resourcify

  has_many :tickets, dependent: :destroy
  belongs_to :room
  belongs_to :movie
  belongs_to :location
  belongs_to :cinema

  validates :room_id, :movie_id, :start_time, :fare, presence: true

  validate :no_overlapping_showtimes

  scope :ordered, -> { order(id: :desc) }

  after_create_commit do
    broadcast_prepend_to 'admin', partial: 'admin/showtimes/showtime',
                                  locals: { showtime: self }
  end

  after_update_commit do
    broadcast_replace_to 'admin', partial: 'admin/showtimes/showtime'
  end

  after_destroy_commit do
    broadcast_remove_to 'admin'
  end

  def self.search(term)
    if term
      joins(:room).where('rooms.name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end

  def self.by_filter(search_term, room_filter, movie_filter)
    left_outer_joins(:movie, :room)
      .where('LOWER(movies.name) LIKE ?', "%#{search_term.downcase}%")
      .where(movies: { id: movie_filter.presence || Movie.ids })
      .where(rooms: { id: room_filter.presence || Room.ids })
  end

  def no_overlapping_showtimes
    overlapping_showtimes = Showtime.where(room_id:)
                                    .where.not(id:)
                                    .where(
                                      '(start_time <= :start_time AND :start_time <= end_time)
                                      OR (start_time >= :start_time AND start_time <= :end_time)',
                                      { start_time:, end_time: }
                                    )

    errors.add(:start_time, 'conflicts with existing showtimes') if overlapping_showtimes.exists?
  end
end
