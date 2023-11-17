class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tickets, dependent: :destroy
  has_one :profile, dependent: :destroy
  has_many :notifications

  accepts_nested_attributes_for :profile

  after_create :assign_default_role

  scope :ordered, -> { order(id: :desc) }

  scope :get_top_customers, ->(number, period) {
    joins(:tickets)
      .select('users.*, SUM(tickets.price) as total_price')
      .where(tickets: { created_at: (Time.current - period.days).. })
      .group('users.id')
      .order('total_price DESC')
      .limit(number)
  }

  scope :customers_chart_data, ->(period) {
    order('date(created_at) ASC').group('date(created_at)').where(created_at: (Time.current - period.days)..).count(:id)
  }

  scope :total_new_users, ->(period) {
    order('date(created_at) ASC').where(created_at: (Time.current - period.days)..).count
  }

  after_create_commit do
    broadcast_prepend_to 'admin', partial: 'admin/users/user',
                                  locals: { user: self }
  end

  after_update_commit do
    broadcast_replace_to 'admin', partial: 'admin/users/user'
  end

  after_destroy_commit do
    broadcast_remove_to 'admin'
  end

  def self.by_filter(search_term)
    left_outer_joins(:profile)
      .where('LOWER(profiles.fullname) LIKE ?', "%#{search_term.downcase}%")
  end

  def assign_default_role
    if email == 'martin.nguyen.goldenowl@gmail.com'
      add_role(:admin)
    else
      add_role(:customer)
    end
  end

  def delete_roles
    roles.delete(roles.where(id: roles.ids))
  end

  def change_role_admin
    return unless has_role? :customer

    remove_role :customer
    add_role :admin
  end

  def unviewed_notifications_count
    notifications.unviewed.count
  end

  def unviewed_notifications
    notifications.unviewed
  end
end
