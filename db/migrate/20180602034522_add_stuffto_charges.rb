class AddStufftoCharges < ActiveRecord::Migration[5.1]
  def change
  	add_column :charges, :postal_code, :int
  	add_column :charges, :charge_status, :int
  end
end
