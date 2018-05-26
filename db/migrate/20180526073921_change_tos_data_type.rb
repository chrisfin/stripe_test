class ChangeTosDataType < ActiveRecord::Migration[5.1]
  def change
  	remove_column :editors, :tos_acceptance_date
  	add_column :editors, :tos_acceptance_date, :int
  end
end
