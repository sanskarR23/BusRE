
class ReservationCleanupJob < ApplicationJob
  queue_as :default

  def perform
    reservations_to_remove = Reservation.where("reservation_date < ?", Date.current)
    reservations_to_remove.destroy_all
  end
end