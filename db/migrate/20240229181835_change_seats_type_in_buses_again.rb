class ChangeSeatsTypeInBusesAgain < ActiveRecord::Migration[7.1]
  def change
    change_column :buses, :seats, :text
  end
end
