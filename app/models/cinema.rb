class Cinema < ApplicationRecord
  resourcify

  belongs_to :location

  has_many :rooms, dependent: :destroy
  has_many :supplies, dependent: :destroy
  has_many :showtimes, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :location_id, presence: true

  scope :ordered, -> { order(id: :desc) }

  after_create_commit lambda {
    broadcast_prepend_to 'admin', partial: 'admin/cinemas/cinema',
                                  locals: { cinema: self }
  }
  after_update_commit lambda {
                        broadcast_replace_to 'admin', partial: 'admin/cinemas/cinema'
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
