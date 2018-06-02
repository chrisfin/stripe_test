class ModifyCharges < ActiveRecord::Migration[5.1]
  def change
  	remove_column :charges, :charge_status
  	add_column :charges, :charge_status, :string
  end
end
