class RemoveFieldsFromBus < ActiveRecord::Migration[7.1]
  def change
    remove_column :buses, :user_id
    rename_column :buses, :seats, :number_of_seats
  end
end
