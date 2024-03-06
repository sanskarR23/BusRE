class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bus, null: false, foreign_key: true
      t.date :date
      t.integer :seats_booked

      t.timestamps
    end
  end
end
