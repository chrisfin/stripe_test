class AddEditorIDtoCharges < ActiveRecord::Migration[5.1]
  def change
  	add_column :charges, :editor_id, :integer
  end
end
