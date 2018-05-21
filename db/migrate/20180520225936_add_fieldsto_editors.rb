class AddFieldstoEditors < ActiveRecord::Migration[5.1]
  def change
  	remove_column :editors, :name
  	add_column :editors, :first_name, :string
  	add_column :editors, :last_name, :string
  	add_column :editors, :dob, :date
  	add_column :editors, :address, :string
  	add_column :editors, :postal_code, :integer
  	add_column :editors, :state, :string
  	add_column :editors, :country, :string
  	add_column :editors, :ssn_last_4, :integer
  	add_column :editors, :personal_id_number, :integer
  	add_column :editors, :id_document, :integer
  	add_column :editors, :entity_type, :string
  	add_column :editors, :tos_acceptance_date, :date
  	add_column :editors, :tos_acceptance_IP, :string
  end
end
