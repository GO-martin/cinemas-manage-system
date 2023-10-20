class Movie < ApplicationRecord
  resourcify

  enum :status, { now_showing: 'now_showing', coming_soon: 'coming_soon' }

  validates :director, :name, :length, presence: true

  scope :ordered, -> { order(id: :desc) }

  has_one_attached :poster, dependent: :destroy
  has_one_attached :banner, dependent: :destroy

  def self.search(term)
    if term
      where('(name LIKE :term) OR (director LIKE :term)', { term: "%#{term}%" }).ordered
    else
      ordered
    end
  end
end
