class AddNumberOfSeatsToReservations < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :number_of_seats
    add_ column :reservations, :seat_number, :integer
  end
end
