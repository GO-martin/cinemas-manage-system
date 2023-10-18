class Showtime < ApplicationRecord
  resourcify

  belongs_to :room
  belongs_to :movie

  validates :room_id, :movie_id, :start_time, :fare, presence: true

  validate :no_overlapping_showtimes

  scope :ordered, -> { order(id: :desc) }

  def self.search(term)
    if term
      joins(:room).where('rooms.name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
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
