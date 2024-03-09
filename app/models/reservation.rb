class Reservation < ApplicationRecord
  serialize :seats, type: Array, coder: JSON
  belongs_to :user
  belongs_to :bus
  validates :reservation_date, :seats, presence: true
  validate :reservation_seat_should_not_repeat

  def reservation_seat_should_not_repeat
    reserved_seats = bus.reservations.pluck(:seats).flatten

    if self.seats.include?(reserved_seats)
      errors.add(:base, "This seat is already reserved, Please select another")
    end
  end
end
  