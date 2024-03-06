class Reservation < ApplicationRecord
   serialize :allocated_seats, type: Array, coder: JSON
  belongs_to :user
  belongs_to :bus
  validates :reservation_date, :seats, presence: true
end



  