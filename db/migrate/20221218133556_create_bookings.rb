class CreateBookings < ActiveRecord::Migration[7.0]
  def change
    create_table :bookings do |t|
      t.references :room, null: false, foreign_key: true
      t.date :date, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
