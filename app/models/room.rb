class Room < ApplicationRecord
  include Structure
  resourcify

  has_many :structure_of_rooms, dependent: :destroy
  has_many :showtimes, dependent: :destroy

  belongs_to :cinema

  validates :name, :cinema_id, presence: true
  after_initialize :set_defaults

  scope :ordered, -> { order(id: :desc) }

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end

  def set_defaults
    return unless new_record?

    self.number_of_seats ||= Structure::NUMBER_OF_SEATS
  end
end
