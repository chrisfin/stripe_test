class ChangeCusId < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :cus_id
  	add_column :users, :cus, :string
  end
end
