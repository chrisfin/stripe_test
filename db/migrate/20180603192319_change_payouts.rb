class ChangePayouts < ActiveRecord::Migration[5.1]
  def change
  	remove_column :editors, :payouts_enabled
  	add_column :editors, :payouts_enabled, :boolean
  end
end
