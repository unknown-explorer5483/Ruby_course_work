class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.float  :money, default: 0



      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
