class AddIndexes < ActiveRecord::Migration[7.0]
  def change
    add_index :bookings, [:date, :room], unique: true
  end
end
