class TicketSupply < ApplicationRecord
  belongs_to :ticket
  belongs_to :supply
end
