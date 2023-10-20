class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role

  scope :ordered, -> { order(id: :desc) }

  def self.search(term)
    if term
      where('email LIKE ?', "%#{term}%").ordered
    else
      ordered
    end
  end

  def assign_default_role
    add_role(:customer) if roles.blank?
  end
end
