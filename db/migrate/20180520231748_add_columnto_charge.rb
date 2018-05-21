class AddColumntoCharge < ActiveRecord::Migration[5.1]
  def change
  	add_column :charges, :source, :string
  	remove_column :charges, :token
  	add_column :charges, :txn_id, :string
  end
end
