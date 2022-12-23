class CreateRooms < ActiveRecord::Migration[7.0]
  def change
    create_table :rooms do |t|
      t.references :hotel, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.float :cost_per_night

      t.timestamps
    end
  end
end
