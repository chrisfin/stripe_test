class CreateApps < ActiveRecord::Migration[5.1]
  def change
    create_table :apps do |t|
      t.string :name
      t.integer :editor_id
      t.float :amount

      t.timestamps
    end
  end
end
