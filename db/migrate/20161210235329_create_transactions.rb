class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :payee_id
      t.string :description
      t.integer :amount
      t.boolean :income
      t.integer :category_id
      t.integer :budget_id
      t.timestamp :transaction_on

      t.timestamps null: false
    end
  end
end
