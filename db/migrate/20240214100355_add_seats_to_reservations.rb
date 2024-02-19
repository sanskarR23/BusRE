class AddSeatsToReservations < ActiveRecord::Migration[7.1]
  def change
    add_column :reservations, :seats, :integer
  end
end
