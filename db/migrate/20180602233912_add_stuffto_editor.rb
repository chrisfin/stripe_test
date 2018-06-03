class AddStufftoEditor < ActiveRecord::Migration[5.1]
  def change
  	add_column :editors, :verification_status_le, :string
  	add_column :editors, :verification_disabled_reason, :string
  	add_column :editors, :verification_fields_needed, :string
  end
end
