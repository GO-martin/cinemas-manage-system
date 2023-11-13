class Cinema < ApplicationRecord
  resourcify

  belongs_to :location

  has_many :rooms, dependent: :destroy
  has_many :supplies, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :location_id, presence: true

  scope :ordered, -> { order(id: :desc) }

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end
end
