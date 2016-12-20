class CreatePayees < ActiveRecord::Migration
  def change
    create_table :payees do |t|
      t.string :payee

      t.timestamps null: false
    end
  end
end
