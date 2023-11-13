class Movie < ApplicationRecord
  resourcify

  validates :director, presence: true

  scope :ordered, -> { order(id: :desc) }

  has_one_attached :poster, dependent: :destroy
  has_one_attached :trailer, dependent: :destroy

  def self.search(term)
    if term
      where('director LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end
end
