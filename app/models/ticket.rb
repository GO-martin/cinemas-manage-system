class Ticket < ApplicationRecord
  resourcify

  belongs_to :user
  belongs_to :showtime

  has_many :ticket_supplies
  has_many :supplies, through: :ticket_supplies
  scope :ordered, -> { order(id: :desc) }

  def self.by_filter(search_term, movie_filter, room_filter)
    left_outer_joins(showtime: %i[movie room])
      .where('LOWER(movies.name) LIKE ?', "%#{search_term.downcase}%")
      .where(movies: { id: movie_filter.presence || Movie.ids })
      .where(rooms: { id: room_filter.presence || Room.ids })
  end
end
