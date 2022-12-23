class ChangeDefaultMoney < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:users, :money, 0)
  end
end
