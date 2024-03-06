class RemoveFromReservation < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :seats_booked
  end
end
