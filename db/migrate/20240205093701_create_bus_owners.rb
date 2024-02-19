class CreateBusOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :bus_owners do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :registration_no

      t.timestamps
    end
  end
end
