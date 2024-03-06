class RemoveDateFromReservations < ActiveRecord::Migration[7.1]
  def change
    remove_column :reservations, :date, :date
  end
end