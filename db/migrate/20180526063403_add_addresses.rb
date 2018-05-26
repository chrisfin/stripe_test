class AddAddresses < ActiveRecord::Migration[5.1]
  def change
  	add_column :charges, :address, :string
  	add_column :charges, :city, :string
  	add_column :charges, :state, :string
  end
end
