class Room < ApplicationRecord
  include Structure
  resourcify

  has_many :structure_of_rooms, dependent: :destroy
  has_many :showtimes, dependent: :destroy

  belongs_to :cinema

  validates :name, :cinema_id, :row_size, :column_size, presence: true
  after_initialize :set_defaults

  scope :ordered, -> { order(id: :desc) }

  after_create_commit do
    broadcast_prepend_to 'admin', partial: 'admin/rooms/room',
                                  locals: { room: self }
  end

  after_update_commit do
    broadcast_replace_to 'admin', partial: 'admin/rooms/room'
  end

  after_destroy_commit do
    broadcast_remove_to 'admin'
  end

  def set_defaults
    return unless new_record?

    self.number_of_seats ||= Structure::NUMBER_OF_SEATS
    self.row_size ||= Structure::ROW_SIZE
    self.column_size ||= Structure::COLUMN_SIZE
  end

  def self.by_filter(search_term, cinema_filter)
    left_outer_joins(:cinema)
      .where('LOWER(rooms.name) LIKE ?', "%#{search_term.downcase}%")
      .where(cinemas: { id: cinema_filter.presence || Cinema.ids })
  end
end
