class Supply < ApplicationRecord
  resourcify

  has_many :tickets, through: :ticket_supplies
  belongs_to :cinema

  validates :name, :quantity, :price, :cinema_id, presence: true

  scope :ordered, -> { order(id: :desc) }

  scope :quantity_more_than, ->(quantity) { where('quantity > ?', quantity) }

  has_one_attached :image, dependent: :destroy

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end
end
