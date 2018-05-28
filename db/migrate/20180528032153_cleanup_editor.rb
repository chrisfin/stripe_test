class CleanupEditor < ActiveRecord::Migration[5.1]
  def change
  	remove_column :editors, :address
  	remove_column :editors, :postal_code
  	remove_column :editors, :state
  	remove_column :editors, :country
  	remove_column :editors, :ssn_last_4
  	remove_column :editors, :personal_id_number
  	remove_column :editors, :id_document
  	remove_column :editors, :entity_type
  	remove_column :editors, :tos_acceptance_IP
  	remove_column :editors, :bank_name
  	remove_column :editors, :bank_routing
  	remove_column :editors, :tos_acceptance_date
  	remove_column :editors, :city
  end
end
