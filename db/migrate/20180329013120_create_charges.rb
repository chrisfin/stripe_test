class CreateCharges < ActiveRecord::Migration[5.1]
  def change
    create_table :charges do |t|
      t.string :token
      t.float :amount
      t.integer :user_id

      t.timestamps
    end
  end
end
