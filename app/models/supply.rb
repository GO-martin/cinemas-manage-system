class Supply < ApplicationRecord
  resourcify

  has_many :ticket_supplies

  has_many :tickets, through: :ticket_supplies
  belongs_to :cinema

  validates :name, :quantity, :price, :cinema_id, presence: true

  scope :ordered, -> { order(id: :desc) }

  scope :quantity_more_than, ->(quantity) { where('quantity > ?', quantity) }

  has_one_attached :image, dependent: :destroy

  after_create_commit do
    broadcast_prepend_to 'admin', partial: 'admin/supplies/supply',
                                  locals: { supply: self }
  end

  after_update_commit do
    broadcast_replace_to 'admin', partial: 'admin/supplies/supply'
  end

  after_destroy_commit do
    broadcast_remove_to 'admin'
  end

  def self.by_filter(search_term, cinema_filter)
    left_outer_joins(:cinema)
      .where('LOWER(supplies.name) LIKE ?', "%#{search_term&.downcase}%")
      .where(cinemas: { id: cinema_filter.presence || Cinema.ids })
  end
end
