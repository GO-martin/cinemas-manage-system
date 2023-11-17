class Location < ApplicationRecord
  resourcify

  has_many :cinemas
  has_many :showtimes

  validates :name, presence: true, uniqueness: true

  scope :ordered, -> { order(id: :desc) }

  scope :locations_chart_data, ->(period) {
    joins(showtimes: :tickets).select('locations.*, SUM(tickets.price) as total_price').where(tickets: { created_at: (Time.current - period.days).. }).group('locations.id').order('total_price ASC')
  }

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

  def self.by_filter(search_term)
    where('LOWER(locations.name) LIKE ?', "%#{search_term.downcase}%")
  end
end
