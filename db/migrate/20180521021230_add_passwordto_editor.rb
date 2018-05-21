class AddPasswordtoEditor < ActiveRecord::Migration[5.1]
  def change
  	 add_column :editors, :password_digest, :string
  end
end
