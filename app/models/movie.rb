class Movie < ApplicationRecord
  resourcify

  validates :director, :description, :releaseDate, presence: true

  # validate :acceptable_image

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

  # def acceptable_image
  #   return unless poster.attached?

  #   errors.add(:poster, 'is too big') unless poster.blob.byte_size <= 1.megabyte

  #   acceptable_types = ['image/jpeg', 'image/png']
  #   return if acceptable_types.include?(poster.content_type)

  #   errors.add(:poster, 'must be a JPEG or PNG')
  # end
end
