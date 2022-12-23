class CreateHotels < ActiveRecord::Migration[7.0]
  def change
    create_table :hotels do |t|
      t.string :location
      t.string :name
      t.text :description

      t.timestamps
    end
    add_index :hotels, :location, unique: true
  end
end
