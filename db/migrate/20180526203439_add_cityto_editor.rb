class AddCitytoEditor < ActiveRecord::Migration[5.1]
  def change
  	add_column :editors, :city, :string
  end
end
