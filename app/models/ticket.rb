class Ticket < ApplicationRecord
  resourcify
  include Notificable

  belongs_to :user
  belongs_to :showtime

  has_many :ticket_supplies
  has_many :supplies, through: :ticket_supplies
  scope :ordered, -> { order(id: :desc) }

  after_create_commit do
    broadcast_prepend_to 'admin', partial: 'admin/tickets/ticket',
                                  locals: { ticket: self }
  end

  after_update_commit do
    broadcast_replace_to 'admin', partial: 'admin/tickets/ticket'
  end

  after_destroy_commit do
    broadcast_remove_to 'admin'
  end

  def self.by_filter(search_term, movie_filter, room_filter)
    left_outer_joins(showtime: %i[movie room])
      .where('LOWER(movies.name) LIKE ?', "%#{search_term.downcase}%")
      .where(movies: { id: movie_filter.presence || Movie.ids })
      .where(rooms: { id: room_filter.presence || Room.ids })
  end

  def user_ids
    User.where.not(id: user_id).with_role(:admin).ids
  end

  scope :total_revenue, ->(period) {
    where(created_at: (Time.current - period.days)..).sum(:price)
  }

  scope :main_chart_data, ->(period) {
    order('date(created_at) ASC').group('date(created_at)').where(created_at: (Time.current - period.days)..).sum(:price)
  }

  scope :tickets_chart_data, ->(period) {
    order('date(created_at) ASC').group('date(created_at)').where(created_at: (Time.current - period.days)..).count(:id)
  }

  scope :total_new_tickets, ->(period) {
    order('date(created_at) ASC').where(created_at: (Time.current - period.days)..).count
  }
end
