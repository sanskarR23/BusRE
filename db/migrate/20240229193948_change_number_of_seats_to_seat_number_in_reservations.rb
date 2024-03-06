class ChangeNumberOfSeatsToSeatNumberInReservations < ActiveRecord::Migration[7.1]
  def change
    rename_column :reservations, :number_of_seats, :seat_number
  end
end
