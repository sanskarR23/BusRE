# db/migrate/YYYYMMDDHHMMSS_change_column_type_in_examples.rb
class ChangeDataTypeOfSeatsInReservation < ActiveRecord::Migration[7.0]
  def change
    # remove_column :reservations, :seats
    # add_column :reservations, :seats, :integer
  end
end
