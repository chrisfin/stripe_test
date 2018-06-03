class AddPayoutsToEditors < ActiveRecord::Migration[5.1]
  def change
  	add_column :editors, :payouts_enabled, :string
  end
end
