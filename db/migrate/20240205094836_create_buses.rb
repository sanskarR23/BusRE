class CreateBuses < ActiveRecord::Migration[7.1]
  def change
    create_table :buses do |t|
      t.string :name
      t.string :registration_no
      t.string :route
      t.integer :seats
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
