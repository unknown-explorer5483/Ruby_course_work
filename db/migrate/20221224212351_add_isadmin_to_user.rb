class AddIsadminToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :isadmin, :boolean
    change_column_default(:users, :isadmin, false)
  end
end
