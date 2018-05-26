class AddAccounttoEditors < ActiveRecord::Migration[5.1]
  def change
  	add_column :editors, :bank_name, :string
  	add_column :editors, :bank_account, :int
  	add_column :editors, :bank_routing, :int
  end
end
