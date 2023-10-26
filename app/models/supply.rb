class Supply < ApplicationRecord
  resourcify

  has_many :tickets
  belongs_to :cinema

  validates :name, :quantity, :price, :cinema_id, presence: true

  scope :ordered, -> { order(id: :desc) }

  has_one_attached :image, dependent: :destroy

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end
end
