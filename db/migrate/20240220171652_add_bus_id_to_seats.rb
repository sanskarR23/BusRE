class AddBusIdToSeats < ActiveRecord::Migration[7.1]
  def change
    add_reference :seats, :bus, null: false, foreign_key: true
  end
end
