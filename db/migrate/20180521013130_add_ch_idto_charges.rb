class AddChIdtoCharges < ActiveRecord::Migration[5.1]
  def change
  	add_column :charges, :ch_id, :string
  end
end
