class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :budget
      t.integer :total

      t.timestamps null: false
    end
  end
end
