class CreateOperations < ActiveRecord::Migration[7.0]
  def change
    create_table :operations do |t|
      t.string :author
      t.references :user, index: true, foreign_key: { to_table: :users}
      t.string :name
      t.decimal :amount
      
      t.timestamps
    end
  end
end
