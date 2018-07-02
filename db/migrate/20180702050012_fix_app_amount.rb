class FixAppAmount < ActiveRecord::Migration[5.1]
  def change
  	remove_column :apps, :amount
  	add_column :apps, :amount, :integer
  end
end
