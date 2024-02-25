class RemoveSeatTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :seats
  end
end
