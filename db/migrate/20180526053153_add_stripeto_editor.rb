class AddStripetoEditor < ActiveRecord::Migration[5.1]
  def change
  	add_column :editors, :acct_id, :string
  end
end
