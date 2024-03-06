class ChangeSeatToArrayInReservationn < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :seats
    add_column :reservations, :seats, :text, default: ""
  end
end
