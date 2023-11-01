class Ticket < ApplicationRecord
  resourcify

  belongs_to :user
  belongs_to :showtime
  # belongs_to :supply

  has_many :supplies, through: :ticket_supplies

  scope :ordered, -> { order(id: :desc) }

  def self.search(term)
    if term
      joins(:user).where('users.name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end
end
