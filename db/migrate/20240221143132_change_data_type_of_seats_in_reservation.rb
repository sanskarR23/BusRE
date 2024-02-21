# db/migrate/YYYYMMDDHHMMSS_change_column_type_in_examples.rb
class ChangeDataTypeOfSeatsInReservation < ActiveRecord::Migration[7.0]
  def change
    remove_column :reservations, :seats
    add_column :reservations, :seats, :text
  end
end


r = Reservation.new(user_id: User.first.id,
bus_id: Bus.first.id,
date: Date.today,
seats_booked: 1,
reservation_date: Date.today,
seats: [1,2,3]
)