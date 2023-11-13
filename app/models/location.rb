class Location < ApplicationRecord
  resourcify

  has_many :cinemas
  has_many :showtimes

  validates :name, presence: true, uniqueness: true

  scope :ordered, -> { order(id: :desc) }

  def self.search(term)
    if term
      where('name LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end
end
