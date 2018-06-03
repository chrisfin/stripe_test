class FixEditorBankAccount < ActiveRecord::Migration[5.1]
  def change
  	remove_column :editors, :bank_account
  	add_column :editors, :ba_id, :string
  end
end
