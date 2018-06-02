class AddCustoCharges < ActiveRecord::Migration[5.1]
  def change
  	 add_column :charges, :cus, :string
  end
end
